module ApplicationHelper
  def app_name
    "UDOLGC Treasurers"
  end
	
	def show_questionnaire
		current_user && (current_user.treasurer && current_user.treasurer.treasurer_type && Treasurer::TREASURER_TYPE.key(current_user.treasurer.treasurer_type) && Treasurer::TREASURER_TYPE.key(current_user.treasurer.treasurer_type).downcase.include?("head") && current_user.treasurer.verified) || current_user.admin? || current_user.principal_treasurer?
		
	end
end
