class Performance < ApplicationRecord
	WHEN_COUNTED = {"Immediately after church service" => "0","1 -2 hours after service" => "1", "3-6 hours after service" => "2", "Greater than 6 hours" => "3"}
	serialize :who_came, Array
	serialize :who_counted, Array
	
end
