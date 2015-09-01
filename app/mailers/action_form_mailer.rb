class ActionFormMailer < ApplicationMailer
  def action_form_email(attributes)
    @body = attributes.delete('body')
    mail(attributes)
  end
end
