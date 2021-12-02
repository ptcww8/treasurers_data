class Performance < ApplicationRecord
	WHEN_COUNTED = {"15 minutes" => "0", "30 minutes" => "1", "45 minutes" => "2", "1 hour" => "3", "more than 1 hour" => "4"}
	WHEN_PAID = {"within 24 hours" => "0", "after 24 hours" => "1"}
  belongs_to :user, foreign_key: "completed_by"
	serialize :who_came, Array
	serialize :who_counted, Array
	validates_presence_of :service_type, :sunday_service, :who_counted, :who_came, :branch_id, :completed_by
	SERVICE_TYPES = {"SUNDAY 1ST SERVICE" => "2", "SUNDAY 2ND SERVICE" => "3", "SUNDAY 3RD SERVICE" => "4", "SUNDAY 4TH SERVICE" => "5", "SUNDAY 5TH SERVICE" => "6", "SUNDAY 6TH SERVICE" => "7", "SUNDAY 7TH SERVICE" => "8", "ALL NIGHT SERVICE" => "22",
"BACENTA SUNDAY SERVICE" => "19", "CHRISTMAS SERVICE" => "15", "CONVENTION" => "13", "MIDWEEK SERVICE" => "9", "MINISTRY MEETING" => "10", "NIGHT SCHOOL" => "14", "NO SERVICE" => "18", "PRAYER MEETING" => "11", "SAVED SERVICE" => "21", "CENTER SERVICE" => "0", "SPECIAL SERVICE" => "17", "SUNDAY GATHERING SERVICE" => "12", "SUNDAY SERVICE - MEETING ON A FRIDAY" => "20", "SUNDAY SERVICE - MEETING ON A SATURDAY" => "1", "WATCH NIGHT SERVICE" => "16"}

	QUESTION_TYPES = {"How many treasurers counted?" => "treasurer_count", "When did counting start after service?" => "counting_start", "When was it paid into the bank or sent via mobile money or paid to council treasurer?" => "when_deposit"}
	
	def self.generate_reports
		
		Branch.pluck(:council).uniq.each {|council| Branch.generate_report(council)}
	end
end
