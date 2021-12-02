class Branch < ApplicationRecord
  
  
  
  def self.pull_branches_councils

    require 'csv'
    branches_csv_path = Dir.pwd+"/db/seeds/Branch.csv"
    puts branches_csv_path

    csv_text = File.read(branches_csv_path)
    csv = CSV.parse(csv_text, :headers => true)
    cnt = 0
    csv.each do |row|
      puts "#{row["BRANCH"]} -- #{row["COUNCIL"]}"
      branch = Branch.find_by(branch: row["BRANCH"], council: row["COUNCIL"])
      unless branch.present?
        puts "Adding new branch ==> #{row["BRANCH"]} - #{row["COUNCIL"]}"
        Branch.create(branch: row["BRANCH"], council: row["COUNCIL"])
        cnt = cnt+1
      end
    end
    puts "#{cnt} new branches added"
    return cnt
  end

  def delinquent_who_counted(start_date= Date.today.beginning_of_month, end_date=Date.today.end_of_month)
    results = Hash.new{0}
    current_branches = Branch.where(council: self.council).order(branch: :asc).pluck(:branch)
    performances = Performance.where(branch_id: current_branches, sunday_service: start_date..end_date)
    performances.each do |perf|
      results[perf.branch_id] = results[perf.branch_id] + 1 unless (perf.who_counted && perf.who_counted.size >=2)	
    end
    final_results = results.sort_by { |branch, def_times| -def_times }
    final_results
  end


  def delinquent_when_counted(start_date= Date.today.beginning_of_month, end_date=Date.today.end_of_month)
    results = Hash.new{0}
    current_branches = Branch.where(council: self.council).order(branch: :asc).pluck(:branch)
    performances = Performance.where(branch_id: current_branches, sunday_service: start_date..end_date)
    performances.each do |perf|
      results[perf.branch_id] = results[perf.branch_id] + 1 if (perf.when_counted && perf.when_counted.to_i >= 4)
    end
    final_results = results.sort_by { |branch, def_times| -def_times }
    final_results
  end

  def delinquent_when_paid(start_date= Date.today.beginning_of_month, end_date=Date.today.end_of_month)
    results = Hash.new{0}
    current_branches = Branch.where(council: self.council).order(branch: :asc).pluck(:branch)
    performances = Performance.where(branch_id: current_branches, sunday_service: start_date..end_date)
    performances.each do |perf|
      results[perf.branch_id] = results[perf.branch_id] + 1 if (perf.when_paid && perf.when_paid.to_i > 0)
    end
    final_results = results.sort_by { |branch, def_times| -def_times }
    final_results
  end


  def self.generate_report(council, start_date = Date.today.beginning_of_month, end_date = Date.today.end_of_month)

    principal_treasurers = User.joins(:treasurer).where(treasurers: {council: council}, role: User.roles[:principal_treasurer]).pluck(:email)
    puts "No principal treasurers exist for #{council}" && return if principal_treasurers.blank?
    who_counted = self.delinquent_who_counted(start_date, end_date)
    when_counted = self.delinquent_when_counted(start_date, end_date)
    when_paid = self.delinquent_when_paid(start_date, end_date)

    puts "No data to email" and return if (who_counted.blank? && when_counted.blank? && when_paid.blank?)
    GenerateMonthlyReportMailer.send_notification_to_principal(emails: principal_treasurers, who_counted: who_counted, when_counted: when_counted, when_paid: when_paid, start_date: start_date, end_date: end_date).deliver_now

  end
end
