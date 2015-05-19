ActiveAdmin.register Tax do
  menu parent: 'Localization'

  permit_params :name, :rate

  index do
    selectable_column
    id_column
    column :name
    column :rate
    actions
  end

  filter :name
  filter :rate

  form do |f|
    f.inputs 'Tax Details' do
      f.input :name
      f.input :rate
    end
    f.actions
  end
end
