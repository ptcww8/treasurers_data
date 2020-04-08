desc "This task is called by the Heroku scheduler add-on to run reports"
task :generate_reports => :environment do
  puts "Generating reports..."
	if Date.today != Date.today.end_of_month
	  puts "Today is not end of month"
		next
	end
  Performance.generate_reports
  puts "done."
end