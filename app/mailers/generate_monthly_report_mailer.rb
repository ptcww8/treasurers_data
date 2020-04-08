class GenerateMonthlyReportMailer < ApplicationMailer
	
	def send_notification_to_principal(emails:, who_counted:, when_counted:, when_paid:, start_date:, end_date:)
		
    @who_counted = who_counted
		@when_counted = when_counted
		@when_paid = when_paid
		@start_date = start_date
		@end_date = end_date
		mail(to: emails, subject: "Report from #{start_date.strftime("%A, %d %B %Y")} to #{end_date.strftime("%A, %d %B %Y")}") do |format|
      format.html { render 'email_content'}
    end
	end
	
	
	
	
end
