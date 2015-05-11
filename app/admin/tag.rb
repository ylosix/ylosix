ActiveAdmin.register Tag do
  menu parent: 'Catalog'

  permit_params :parent_id, :name, :priority

  index do
    selectable_column
    id_column

    column 'Parent' do |tag|
      array = Utils.get_parents_array(tag)
      (array.map{ |item| auto_link(item, item.name) }).join(' || ').html_safe
    end

    column :name
    column :appears_in_web
    column :priority
    actions
  end

  filter :name
  filter :appears_in_web

  form do |f|
    f.inputs 'Tag Details' do
      f.input :parent
      f.input :name
      f.input :appears_in_web
      f.input :priority
    end
    f.actions
  end

end
