ActiveAdmin.register Category do
  menu parent: 'Catalog'

  permit_params :parent_id, :name, :appears_in_web, :meta_title, :meta_description, :slug

  index do
    selectable_column
    id_column
    column :parent
    column :name
    column :appears_in_web
    column :slug
    actions
  end

  filter :name
  filter :appears_in_web

  form do |f|
    f.inputs 'Language Details' do
      f.input :parent
      f.input :name
      f.input :appears_in_web
      f.input :meta_title
      f.input :meta_description
      f.input :slug
    end
    f.actions
  end

end
