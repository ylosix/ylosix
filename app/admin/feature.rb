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

  filter :translations_name, as: :string, label: 'Name'

  form do |f|
    f.inputs 'Feature Details' do
      translations = Utils.array_translations(FeatureTranslation, feature_id: feature.id)
      admin_translation_text_field(translations, 'feature', 'name')

      f.input :priority
    end

    f.actions
  end
end
