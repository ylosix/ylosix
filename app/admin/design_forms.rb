ActiveAdmin.register DesignForm do
  menu parent: 'Preferences'

  permit_params :tag,
                design_form_translations_attributes:
                    [:id, :locale, :content]

  index do
    selectable_column
    id_column

    column :tag

    actions
  end

  form do |f|
    f.inputs 'Action form Details' do
      f.input :tag

      translations = Utils.array_translations(DesignFormTranslation, design_form_id: design_form.id)
      admin_translation_text_field(translations, 'design_form', 'content', component: ActiveAdminHelper::CKEDITOR)
    end

    f.actions
  end
end
