class ApplicationMailer < ActionMailer::Base
  default from: Ecommerce::Application::MAIN_EMAIL
  layout 'mailer'
end
