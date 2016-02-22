module ActiveAdminHelper
  TEXT_AREA = 1
  TEXT_FIELD = 2
  CK_EDITOR = 3
  ACE = 4

  def category_collection_select(no_include_category = nil)
    array = Category.parent_order.map do |c|
      next if no_include_category && no_include_category.id == c.id
      begin
        array = Utils.get_parents_array(c)
        array << c
        c_name = array.map(&:name).join(' | ')

        [c_name, c.id]
      rescue ClassErrors::ParentLoopError
        [c.name, c.id]
      end
    end

    array.compact.sort_by { |item| item[0] }
  end

  def admin_translation_text_field(object, model_name, field, options = {})
    if options[:component] == CK_EDITOR && !session[:locale].nil?
      options[:ckeditor] = {language: session[:locale]}
    end

    languages = Language.in_backoffice
    languages.each do |language|
      label_text = t("activerecord.attributes.#{model_name}.#{field}")
      label_for = "#{model_name}_#{field}_#{language.locale}"

      input_name = "#{model_name}[#{field}][#{language.locale}]"
      value = ''
      value = object[field][language.locale] if object[field]
      render_input_text_field(label_text, label_for, input_name, value, language, options)
    end
  end

  private

  # input_name = 'category[name_translations][en]'
  def render_input_text_field(label_text, label_for, input_name, value, language, options)
    render partial: 'admin/translation_field',
           locals: {
               input_name: input_name,
               language: language,
               label_text: label_text,
               label_for: label_for,
               component: retrieve_component("#{input_name}", value, options)
           }
  end

  def retrieve_component(input_name, value, options)
    case options[:component]
      when TEXT_AREA
        output = text_area_tag(input_name, value, options.except(:hint))
      when CK_EDITOR
        output = cktext_area_tag(input_name, value, options.except(:hint))
      when ACE
        output = ace_area_tag(input_name, value, options.except(:hint))
      else
        output = text_field_tag(input_name, value, options.except(:hint))
    end

    unless options[:hint].blank?
      output += content_tag :p, options[:hint], class: 'inline-hints'
    end

    output
  end

  def ace_area_tag(input_name, value, _options)
    input_id = input_name.to_s.delete(']').tr('^-a-zA-Z0-9:.', '_')
    output = javascript_include_tag '/assets/ace-editor-bower/ace.js'

    output += content_tag :div, id: input_id, class: 'editor_html' do
      value
    end

    output += content_tag :textarea, id: "area_#{input_id}", name: input_name, class: 'hide' do
    end

    output += javascript_tag do
      "        var e_#{input_id} = ace.edit('#{input_id}');
               var ta_#{input_id} = $('#area_#{input_id}');
               ta_#{input_id}.val(e_#{input_id}.getSession().getValue());

               e_#{input_id}.setTheme('ace/theme/crimson_editor');
               e_#{input_id}.getSession().setMode('ace/mode/html');

               e_#{input_id}.getSession().on('change', function () {
                  ta_#{input_id}.val(e_#{input_id}.getSession().getValue());
               });
          ".html_safe
    end

    output
  end
end
