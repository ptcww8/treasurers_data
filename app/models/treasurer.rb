class Treasurer < ApplicationRecord
	belongs_to :user
	has_one_attached :image
	validates :image, attached: true, content_type: /(image)(\/)/i
	self.per_page = 20
	serialize :conference, Array
	serialize :debt, Array
	enum tithe: [:yes, :no, :occasionally] 
	validates_presence_of :first_name, :last_name, :date_of_birth, :branch_id, :council, :whatsapp_number, :education_level, :ud_join, :year_treasurer, :treasurer_type, :tithe
	validates_inclusion_of :employment_status, :bishop_podcast, :born_again, :in => [true, false]
 
	EDUCATION = ["primary","secondary", "bachelors","master","doctorate"]
  TREASURER_TYPE = {"Principal treasurer"=> "0","Head treasurer"=> "1","Assistant treasurer"=>"2"}
	TREASURER_TYPE_NO_ADMIN = {"Head treasurer"=> "1","Assistant treasurer"=>"2"}
	DEBT_OBLIGATION = ["mortgage","car loan","school loan", "alimony", "child support", "other(please explain)"]
	
	def image_resized
		#image.variant(resize: "250x250", auto_orient: true)
		image.variant(combine_options: { resize: "250x250>", extent: "250x250", background: "grey", gravity: "center", auto_orient: true})
	end

	def image_profile
		#image.variant(resize: "250x250", auto_orient: true)
		image.variant(combine_options: { resize: "250x250>", extent: "250x250", background: "grey", gravity: "center", auto_orient: true})
	end

	
  def full_name
    "#{first_name} #{last_name}"
  end
	
end