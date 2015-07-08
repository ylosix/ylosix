ActiveAdmin.register Country do
  menu parent: 'Localization'

  permit_params :zone_id, :name, :iso, :enabled, :code

  index do
    selectable_column
    id_column
    column :zone
    column :code
    column :name
    column :iso
    column :enabled

    actions
  end

  filter :zone
  filter :code
  filter :name
  filter :iso
  filter :enabled

  form do |f|
    f.inputs 'Country Details' do
      f.input :zone
      f.input :code
      f.input :name
      f.input :iso
      f.input :enabled
    end
    f.actions
  end
end
