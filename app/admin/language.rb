ActiveAdmin.register Language do
  # config/initializer/active_admin.rb
  menu false

  permit_params :code, :flag, :appears_in_backoffice, :appears_in_web

  index do
    selectable_column
    id_column
    column :code
    column (:flag) { |language| image_tag(language.flag.url(:thumb)) if language.flag? }

    column :appears_in_backoffice
    column :appears_in_web
    actions
  end

  filter :code
  filter :appears_in_backoffice
  filter :appears_in_web

  form do |f|
    f.inputs 'Language Details' do
      f.input :code
      f.input :flag, hint: (f.template.image_tag(f.object.flag.url(:thumb)) if f.object.flag?)
      f.input :appears_in_backoffice
      f.input :appears_in_web
    end
    f.actions
  end
end
