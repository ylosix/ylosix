module ActiveAdminHelper
  TEXT_AREA = 1
  TEXT_FIELD = 2
  CKEDITOR = 3

  def admin_translation_text_field(translations, model_name, field, component = TEXT_FIELD)
    translations.each_with_index do |t, index|
      input_name_prefix = "#{model_name}[#{model_name}_translations_attributes][#{index}]"
      input_name_suffix = field

      render partial: 'admin/translation_field',
             locals: {
                 id: t.id,
                 id_prefix:
                     "#{model_name}_#{model_name}_translations_attributes_#{index}_#{input_name_suffix}",
                 input_name_prefix: input_name_prefix,
                 input_name_sufix: input_name_suffix,
                 language: t.language,
                 component: retrieve_component("#{input_name_prefix}[#{input_name_suffix}]", component, t[field])
             }
    end
  end

  private

  def retrieve_component(input_name, component, value)
    case component
    when TEXT_AREA
      text_area_tag(input_name, value)
    when CKEDITOR
      cktext_area_tag(input_name, value)
    else
      text_field_tag(input_name, value)
    end
  end
end
