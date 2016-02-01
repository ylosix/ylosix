# == Schema Information
#
# Table name: action_forms
#
#  body_translations    :hstore           default({}), not null
#  created_at           :datetime         not null
#  id                   :integer          not null, primary key
#  mapping              :hstore           default({}), not null
#  subject_translations :hstore           default({}), not null
#  tag                  :string
#  updated_at           :datetime         not null
#

class ActionForm < ActiveRecord::Base
  include TemplateFunctions

  translates :subject, :body

  def perform_with_data(data_form)
    attributes = {to: Ecommerce::Application::MAIN_EMAIL}
    data_form_fields = data_form.fields

    mapping.each do |k, v|
      if data_form_fields.key? k
        # ex: replace email => reply_to
        attributes[v.to_sym] = data_form_fields[k]
      else
        # ex: replace to => info@abc.com
        attributes[k.to_sym] = v
      end
    end

    render_attributes(data_form_fields, attributes)
    ActionFormMailer.action_form_email(attributes).deliver_later
  end

  private

  def render_attributes(data_form_fields, attributes)
    locale = data_form_fields[:locale]
    locale ||= I18n.default_locale.to_s

    # Parses and compiles the subject and body
    attributes[:subject] = parse_liquid(data_form_fields, subject_translations[locale])

    # Parses and compiles the body
    attributes[:body] = parse_liquid(data_form_fields, body_translations[locale])
  end
end
