class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	
	
  def after_sign_in_path_for(resource)
    if current_user.treasurer.present?
			treasurer_path(current_user.treasurer)
		else
			new_treasurer_path
		end
  end 
end
