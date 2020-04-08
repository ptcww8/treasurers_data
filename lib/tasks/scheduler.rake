desc "This task is called by the Heroku scheduler add-on to run reports"
task :generate_reports => :environment do
  puts "Generating reports..."
  Performance.generate_reports
  puts "done."
end