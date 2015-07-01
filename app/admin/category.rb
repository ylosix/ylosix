ActiveAdmin.register Category do
  menu parent: 'Catalog'
  permit_params :parent_id, :name, :enabled, :visible, :meta_keywords,
                :meta_description, :slug, :priority,
                category_translations_attributes: [:id, :locale, :name]

  index do
    selectable_column
    id_column

    column 'Parent' do |category|
      array = Utils.get_parents_array(category)
      (array.map { |item| auto_link(item, item.name) }).join(' || ').html_safe
    end

    column :name
    column :enabled
    column :visible
    column :slug
    column :priority
    actions
  end

  filter :translations_name, as: :string, label: 'Name'
  filter :visible

  form do |f|
    f.inputs 'Category Details' do
      f.input :parent

      translations = Utils.array_translations(CategoryTranslation, category_id: category.id)
      admin_translation_text_field(translations, 'category', 'name')

      f.input :enabled
      f.input :visible
      f.input :meta_keywords
      f.input :meta_description
      f.input :slug
      f.input :priority, hint: '1:+ --- 10:-'
    end

    f.actions
  end
end
