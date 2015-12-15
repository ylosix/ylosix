ActiveAdmin.register Feature do
  menu parent: 'Catalog'
  permit_params :name, :priority,
                feature_translations_attributes: [:id, :locale, :name]

  action_item :view, only: :show do
    link_to t('formtastic.add_another', model: t('activerecord.models.feature.one')), new_admin_feature_path
  end

  index do
    selectable_column
    id_column

    column :name, sortable: 'feature_translations.name'
    column :priority
    actions
  end

  filter :translations_name, as: :string, label: proc { I18n.t 'activerecord.attributes.feature.name' }

  form do |f|
    f.inputs t('formtastic.edit_form', model: t('activerecord.models.feature.one')) do
      translations = Utils.array_translations(FeatureTranslation, feature_id: feature.id)
      admin_translation_text_field(translations, 'feature', 'name')

      f.input :priority, hint: '1:+ --- 10:-'
    end

    f.actions
  end
end
