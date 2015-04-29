ActiveAdmin.register Language do
  permit_params :code, :flag, :appears_in_backoffice, :appears_in_web

  index do
    selectable_column
    id_column
    column :code
    column :flag
    column :appears_in_backoffice
    column :appears_in_web
    actions
  end

  filter :code
  filter :flag
  filter :appears_in_backoffice
  filter :appears_in_web

  form do |f|
    f.inputs 'Language Details' do
      f.input :code
      f.input :flag
      f.input :appears_in_backoffice
      f.input :appears_in_web
    end
    f.actions
  end

end
