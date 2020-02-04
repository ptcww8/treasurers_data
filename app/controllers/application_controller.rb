class ApplicationController < ActionController::Base
	protect_from_forgery prepend: true, with: :exception
	before_action :authenticate_user!
	
	
  def after_sign_in_path_for(resource)
		if current_user.admin? || current_user.principal_treasurer?
			treasurers_path
    elsif current_user.treasurer.present?
			treasurer_path(current_user.treasurer)
		else
			new_treasurer_path
		end
  end 
end
