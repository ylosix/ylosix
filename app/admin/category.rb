ActiveAdmin.register Category do
  menu parent: 'Catalog'
  permit_params :parent_id, :name, :enabled, :appears_in_web, :meta_keywords,
                :meta_description, :slug,
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
    column :appears_in_web
    column :slug
    actions
  end

  filter :name
  filter :appears_in_web

  form do |f|
    f.inputs 'Category Details' do
      f.input :parent

      translations = f.object.admin_category_translations
      translations.each_with_index do |t, index|
        render partial: 'admin/translation_field',
               locals: {
                   id: t.id,
                   id_prefix: "category_name_#{t.language.code}_#{index}",
                   input_name_prefix:
                       "category[category_translations_attributes][#{index}]",
                   input_name_sufix: 'name',
                   locale: t.language,
                   value: t.name
               }
      end

      f.input :enabled
      f.input :appears_in_web
      f.input :meta_keywords
      f.input :meta_description
      f.input :slug
    end

    f.actions
  end
end
