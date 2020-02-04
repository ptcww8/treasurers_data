class ApplicationMailer < ActionMailer::Base
  default from: 'info@rubyonrailstrainingstl.com'
  layout 'email'
	helper EmailTemplateHelper
end
