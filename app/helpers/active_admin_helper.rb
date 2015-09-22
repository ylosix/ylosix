module ActiveAdminHelper
  TEXT_AREA = 1
  TEXT_FIELD = 2
  CKEDITOR = 3

  def category_collection_select
    array = Category.parent_order.map do |c|
      array = Utils.get_parents_array(c)
      array << c
      c_name = array.map(&:name).join(' || ')

      [c_name, c.id]
    end

    array
  end

  def admin_translation_text_field(translations, model_name, field, options = {})
    if options[:component] == CKEDITOR && !session[:locale].nil?
      options[:ckeditor] = {language: session[:locale]}
    end

    translations.each_with_index do |translation, index|
      if translation[field].class == Hash
        translation[field].each do |k, v|
          label_text = t("activerecord.attributes.#{model_name}.#{k}")
          label_for = "#{model_name}_#{model_name}_translations_attributes_#{index}_#{field}_#{k}"

          input_prefix_name = "#{model_name}[#{model_name}_translations_attributes][#{index}]"
          input_suffix_name = "[#{field}][#{k}]"

          render_input_text_field(label_text, label_for, input_prefix_name, input_suffix_name, v, translation, options)
        end
      else
        label_text = t("activerecord.attributes.#{model_name}.#{field}")
        label_for = "#{model_name}_#{model_name}_translations_attributes_#{index}_#{field}"

        input_prefix_name = "#{model_name}[#{model_name}_translations_attributes][#{index}]"
        input_suffix_name = "[#{field}]"

        render_input_text_field(label_text, label_for, input_prefix_name, input_suffix_name, translation[field], translation, options)
      end
    end
  end

  private

  # input_prefix_name = 'category[category_translations_attributes][0]'
  # input_suffix_name = '[name]'
  def render_input_text_field(label_text, label_for, input_prefix_name, input_suffix_name, value, translation, options)
    render partial: 'admin/translation_field',
           locals: {
               input_prefix_name: input_prefix_name,
               translation: translation,
               label_text: label_text,
               label_for: label_for,
               component: retrieve_component("#{input_prefix_name}#{input_suffix_name}", value, options)
           }
  end

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
