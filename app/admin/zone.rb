ActiveAdmin.register Zone do
  menu parent: 'Localization'

  permit_params :name, :code

  index do
    selectable_column
    id_column
    column :name
    column :code

    actions
  end

  filter :code
  filter :name

  form do |f|
    f.inputs 'Country Details' do
      f.input :code
      f.input :name
    end
    f.actions
  end
end
