module ActiveAdminHelper
  TEXT_AREA = 1
  TEXT_FIELD = 2
  CKEDITOR = 3

  def admin_translation_text_field(translations, model_name, field, options = {})
    if options[:component] == CKEDITOR && !session[:locale].nil?
      options[:ckeditor] = {language: session[:locale]}
    end

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
                 input_label: t("activerecord.attributes.#{model_name}.#{field}"),
                 component: retrieve_component("#{input_name_prefix}[#{input_name_suffix}]", t[field], options)
             }
    end
  end

  private

  def retrieve_component(input_name, value, options)
    case options[:component]
    when TEXT_AREA
      output = text_area_tag(input_name, value, options.except(:hint))
    when CKEDITOR
      output = cktext_area_tag(input_name, value, options.except(:hint))
    else
      output = text_field_tag(input_name, value, options.except(:hint))
    end

    unless options[:hint].blank?
      output += content_tag :p, options[:hint], class: 'inline-hints'
    end

    output
  end
end
