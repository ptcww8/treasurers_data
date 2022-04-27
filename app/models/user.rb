class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
	has_one :treasurer, dependent: :destroy
  has_many :performances
	enum role: [:admin, :principal_treasurer, :treasurer]

  after_initialize :set_default_role, :if => :new_record? 
  before_destroy :delete_performances
  
  def set_default_role 
    self.role ||= :treasurer
  end 

  def delete_performances
    Performance.where(completed_by: self.id).delete_all
  end 
	
	
	
	
end
