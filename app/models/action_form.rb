# == Schema Information
#
# Table name: action_forms
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  mapping    :hstore           default({}), not null
#  tag        :string
#  updated_at :datetime         not null
#

class ActionForm < ActiveRecord::Base
  translates :subject, :body

  has_many :action_form_translations
  accepts_nested_attributes_for :action_form_translations

  def perform_with_data(data_form)
    attributes = {to: Ecommerce::Application::MAIN_EMAIL}
    mapping.each do |k, v|
      if data_form.fields.key? k
        # ex: replace email => reply_to
        attributes[v.to_sym] = data_form.fields[k]
      else
        # ex: replace info@abc.com => to
        attributes[v.to_sym] = k
      end
    end

    render_attributes(data_form, attributes)
    ActionFormMailer.action_form_email(attributes).deliver_later
  end

  private

  def render_attributes(data_form, attributes)
    locale = I18n.default_locale.to_s
    locale = data_form.fields[:locale] unless data_form.fields[:locale].blank?

    translations = action_form_translations.find_by(locale: locale)
    return if translations.nil?

    # Parses and compiles the subject
    template_liquid = Liquid::Template.parse(translations[:subject])
    attributes[:subject] = template_liquid.render(data_form.fields)

    # Parses and compiles the body
    template_liquid = Liquid::Template.parse(translations[:body])
    attributes[:body] = template_liquid.render(data_form.fields)
  end
end
