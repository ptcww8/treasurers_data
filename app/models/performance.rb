class Performance < ApplicationRecord
	WHEN_COUNTED = {"less than 2 hours" => "0", "more than 2 hours" => "1"}
	WHEN_PAID = {"within 24 hours" => "0", "after 24 hours" => "1"}
	serialize :who_came, Array
	serialize :who_counted, Array
	validates_presence_of :service_type, :sunday_service, :deposit_date, :who_counted, :who_came, :branch_id, :completed_by
	SERVICE_TYPES = {"SUNDAY 1ST SERVICE" => "2", "SUNDAY 2ND SERVICE" => "3", "SUNDAY 3RD SERVICE" => "4", "SUNDAY 4TH SERVICE" => "5", "SUNDAY 5TH SERVICE" => "6", "SUNDAY 6TH SERVICE" => "7", "SUNDAY 7TH SERVICE" => "8", "ALL NIGHT SERVICE" => "22",
"BACENTA SUNDAY SERVICE" => "19", "CHRISTMAS SERVICE" => "15", "CONVENTION" => "13", "MIDWEEK SERVICE" => "9", "MINISTRY MEETING" => "10", "NIGHT SCHOOL" => "14", "NO SERVICE" => "18", "PRAYER MEETING" => "11", "SAVED SERVICE" => "21", "SELECT A TYPE OF SERVICE" => "0", "SPECIAL SERVICE" => "17", "SUNDAY GATHERING SERVICE" => "12", "SUNDAY SERVICE - MEETING ON A FRIDAY" => "20", "SUNDAY SERVICE - MEETING ON A SATURDAY" => "1", "WATCH NIGHT SERVICE" => "16"}
end
