ActiveAdmin.register TagsGroup do
  menu parent: 'Catalog'

  permit_params :name, tags_groups_categories_attributes: [:id, :category_id, :_destroy],
                tags_group_translations_attributes: [:id, :locale, :name]

  index do
    selectable_column
    id_column

    column :name
    actions
  end

  filter :translations_name, as: :string, label: 'Name'

  form do |f|
    f.inputs 'Tag Details' do
      translations = Utils.array_translations(TagsGroupTranslation, tags_group_id: tags_group.id)
      admin_translation_text_field(translations, 'tags_group', 'name')

      f.has_many :tags_groups_categories, allow_destroy: true do |s|
        s.input :category
      end
    end
    f.actions
  end
end
