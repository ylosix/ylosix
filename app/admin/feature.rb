ActiveAdmin.register Feature do
  menu parent: 'Catalog'
  permit_params :name, :priority,
                feature_translations_attributes: [:id, :locale, :name]

  index do
    selectable_column
    id_column

    column :name
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
