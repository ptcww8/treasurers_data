class ApprovalMailer < ApplicationMailer
	
	def send_notification_to_principal(treasurer_id:)
		return unless @treasurer = Treasurer.find_by_id(treasurer_id)
		@principal_treasurers = User.joins(:treasurer).where(role: User.roles["principal_treasurer"]).where("treasurers.council = ?", @treasurer.council).pluck(:email)
    @admins = User.where(role: :admin).pluck(:email)
    @principal_treasurers = @principal_treasurers + @admins
		@to_treasurer = false
		mail(to: @principal_treasurers, subject: "New Treasurer Added") do |format|
      format.html { render 'email_content'}
    end
	end
	
	
	def send_notification_to_treasurer(treasurer_id:)
		return unless @treasurer = Treasurer.find_by_id(treasurer_id)
		@to_treasurer = true
		mail(to: @treasurer.user.email, subject: "New Treasurer Added") do |format|
      format.html { render 'email_content'}
    end
	end	

	def send_notification_after_disapproving(treasurer_id:)
		return unless @treasurer = Treasurer.find_by_id(treasurer_id)
		@approve = false
		mail(to: @treasurer.user.email, subject: "Please Redo Your information") do |format|
      format.html { render 'email_approve_content'}
    end
	end	

	def send_notification_after_approving(treasurer_id:)
		return unless @treasurer = Treasurer.find_by_id(treasurer_id)
		@approve = true
		mail(to: @treasurer.user.email, subject: "You Have Been Approved") do |format|
      format.html { render 'email_approve_content'}
    end
	end	

	def notify_of_privileges(treasurer_id:)
		return unless @treasurer = Treasurer.find_by_id(treasurer_id)
		@approve = true
		mail(to: @treasurer.user.email, subject: "Your Principal Treasurer Privileges") do |format|
      format.html { render 'email_privilege_content'}
    end
	end	
	
end
