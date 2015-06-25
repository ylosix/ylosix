ActiveAdmin.register Tag do
  menu parent: 'Catalog'

  permit_params :tags_group_id, :name, :priority,
                tag_translations_attributes: [:id, :locale, :name]

  index do
    selectable_column
    id_column

    column :tags_group
    column :name
    column :priority
    actions
  end

  filter :translations_name, as: :string, label: 'Name'
  filter :parent
  filter :tags_group

  form do |f|
    f.inputs 'Tag Details' do
      f.input :priority
      f.input :tags_group

      translations = Utils.array_translations(TagTranslation, tag_id: tag.id)
      admin_translation_text_field(translations, 'tag', 'name')
    end
    f.actions
  end
end
