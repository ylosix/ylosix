ActiveAdmin.register ActionForm do
  menu parent: 'Preferences'

  permit_params :tag, :mapping,
                action_form_translations_attributes:
                    [:id, :locale, :subject, :body]

  index do
    selectable_column
    id_column

    column :tag
    column :mapping

    actions
  end

  form do |f|
    f.inputs 'Action form Details' do
      f.input :tag
      f.input :mapping, hint: 'ex: "email" => "reply-to"'

      translations = Utils.array_translations(ActionFormTranslation, action_form_id: action_form.id)
      admin_translation_text_field(translations, 'action_form', 'subject')
      admin_translation_text_field(translations, 'action_form', 'body', component: ActiveAdminHelper::CKEDITOR)
    end

    f.actions
  end

  controller do
    def update
      super

      @action_form[:mapping] = {}
      JSON.parse(params[:action_form][:mapping].gsub('=>', ':')).each do |k, v|
        @action_form[:mapping][k] = v
      end

      @action_form.save
    end
  end
end
