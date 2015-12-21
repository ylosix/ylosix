ActiveAdmin.register Snippet do
  menu parent: 'Design'

  permit_params do
    permitted = [:tag]

    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {content_translations: locales}
    permitted
  end

  index do
    selectable_column
    id_column

    column :tag

    actions
  end

  form do |f|
    f.inputs 'Action form Details' do
      f.input :tag, hint: '{{ include snippets:tag_name }}'

      admin_translation_text_field(snippet, 'snippet', 'content_translations', component: ActiveAdminHelper::ACE)
    end

    f.actions
  end
end
