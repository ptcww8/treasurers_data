class Treasurer < ApplicationRecord
	belongs_to :user
	has_one_attached :image
	self.per_page = 20
	serialize :conference, Array
	enum tithe: [:yes, :no, :occasionally] 
	validates_presence_of :first_name, :last_name, :date_of_birth, :branch_id, :council, :whatsapp_number, :education_level, :ud_join, :year_treasurer, :treasurer_type, :tithe
	validates_inclusion_of :employment_status, :bishop_podcast, :born_again, :training_manual, :in => [true, false]
	EDUCATION = ["primary","secondary", "bachelors","master","doctorate"]
  TREASURER_TYPE = ["principal treasurer","assistant principal treasurer","head treasurer","assistant head treasurer"]
end