class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
	has_one :treasurer, dependent: :destroy
  has_many :performances, dependent: :destroy
	enum role: [:admin, :principal_treasurer, :treasurer]

  after_initialize :set_default_role, :if => :new_record? 
  def set_default_role 
    self.role ||= :treasurer
  end 

	
	
	
	
end
