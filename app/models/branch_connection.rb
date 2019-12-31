class BranchConnection < ActiveRecord::Base
	if Rails.env.production?
		establish_connection(adapter:  "sqlserver", host: ENV["SQL_HOST"], username: ENV["SQL_USERNAME"], password: ENV["SQL_PASSWORD"], database: ENV["SQL_DB_NAME"], azure: true, port: "1433", mode: :dblib)
	else
    establish_connection(:global)
	end
  self.table_name = "EDW_UDBRANCHES"
end