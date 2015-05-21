ActiveAdmin.register Language do
  menu parent: 'Localization'

  permit_params :locale, :flag, :appears_in_backoffice, :appears_in_web, :name

  index do
    selectable_column
    id_column
    column :locale
    column :name
    column (:flag) { |language| image_tag(language.flag.url(:thumb)) if language.flag? }

    column :appears_in_backoffice
    column :appears_in_web
    actions
  end

  filter :locale
  filter :name
  filter :appears_in_backoffice
  filter :appears_in_web

  form do |f|
    f.inputs 'Language Details' do
      f.input :locale
      f.input :name
      f.input :flag, hint: (f.template.image_tag(f.object.flag.url(:thumb)) if f.object.flag?)
      f.input :appears_in_backoffice
      f.input :appears_in_web
    end
    f.actions
  end
end
