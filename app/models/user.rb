class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	has_one :treasurer
	enum role: [:admin, :principal_treasurer, :treasurer]

  after_initialize :set_default_role, :if => :new_record? 
  def set_default_role 
    self.role ||= :treasurer
  end 

	
	
	
	
end
