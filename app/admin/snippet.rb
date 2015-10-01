ActiveAdmin.register Snippet do
  menu parent: 'Design'

  permit_params :tag,
                snippet_translations_attributes:
                    [:id, :locale, :content]

  index do
    selectable_column
    id_column

    column :tag

    actions
  end

  form do |f|
    f.inputs 'Action form Details' do
      f.input :tag, hint: '{{ include snippets:tag_name }}'

      translations = Utils.array_translations(SnippetTranslation, snippet_id: snippet.id)
      admin_translation_text_field(translations, 'snippet', 'content', component: ActiveAdminHelper::ACE)
    end

    f.actions
  end
end
