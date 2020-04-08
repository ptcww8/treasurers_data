class CouncilConnection < ActiveRecord::Base
  if Rails.env.production?
		establish_connection(adapter:  "sqlserver", host: ENV["SQL_HOST"], username: ENV["SQL_USERNAME"], password: ENV["SQL_PASSWORD"], database: ENV["SQL_DB_NAME"], azure: true, port: "1433", mode: :dblib)
	else
    establish_connection(:global)
	end
  self.table_name = "COUNCILS"

	
	def delinquent_who_counted(start_date= Date.today.beginning_of_month, end_date=Date.today.end_of_month)
		results = Hash.new{0}
		current_branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: self.COUNCIL).order(BRANCH: :asc).pluck(:BRANCH)
	  performances = Performance.where(branch_id: current_branches, sunday_service: start_date..end_date)
		performances.each do |perf|
		  results[perf.branch_id] = results[perf.branch_id] + 1 unless (perf.who_counted && perf.who_counted.size >=2)	
		end
		final_results = results.sort_by { |branch, def_times| -def_times }
		final_results
	end
	
	
	def delinquent_when_counted(start_date= Date.today.beginning_of_month, end_date=Date.today.end_of_month)
		results = Hash.new{0}
		current_branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: self.COUNCIL).order(BRANCH: :asc).pluck(:BRANCH)
	  performances = Performance.where(branch_id: current_branches, sunday_service: start_date..end_date)
		performances.each do |perf|
		  results[perf.branch_id] = results[perf.branch_id] + 1 if (perf.when_counted && perf.when_counted.to_i >= 4)
		end
		final_results = results.sort_by { |branch, def_times| -def_times }
		final_results
	end
	
	def delinquent_when_paid(start_date= Date.today.beginning_of_month, end_date=Date.today.end_of_month)
		results = Hash.new{0}
		current_branches = BranchConnection.where(BRANCHSTATUS: "ACTIVE", COUNCIL: self.COUNCIL).order(BRANCH: :asc).pluck(:BRANCH)
	  performances = Performance.where(branch_id: current_branches, sunday_service: start_date..end_date)
		performances.each do |perf|
		  results[perf.branch_id] = results[perf.branch_id] + 1 if (perf.when_paid && perf.when_paid.to_i > 0)
		end
		final_results = results.sort_by { |branch, def_times| -def_times }
		final_results
	end
	
	
	def generate_report(start_date = Date.today.beginning_of_month, end_date = Date.today.end_of_month)
		
		principal_treasurers = User.joins(:treasurer).where(treasurers: {COUNCIL:"LOS ANGELES"}, role: User.roles[:principal_treasurer]).pluck(:email)
		Rails.logger.info "No principal treasurers exist for #{self.COUNCIL}" if principal_treasurers.blank?
		who_counted = self.delinquent_who_counted(start_date, end_date)
		when_counted = self.delinquent_when_counted(start_date, end_date)
		when_paid = self.delinquent_when_paid(start_date, end_date)
		
		return if who_counted.blank? && when_counted.blank? && when_paid.blank?
		
		GenerateMonthlyReportMailer.send_notification_to_principal(emails: principal_treasurers, who_counted: who_counted, when_counted: when_counted, when_paid: when_paid, start_date: start_date, end_date: end_date).deliver_now
		
	end
	
	
	
end