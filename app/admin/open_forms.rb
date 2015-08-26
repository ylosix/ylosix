ActiveAdmin.register OpenForm do
  menu parent: 'Preferences'

  index do
    selectable_column
    id_column

    column :tag
    column :fields

    actions
  end
end
