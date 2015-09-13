ActiveAdmin.register Language do
  menu parent: 'Localization'

  permit_params :locale, :flag, :appears_in_backoffice, :appears_in_web, :default, :name

  index do
    selectable_column
    id_column
    column :locale
    column :name
    column (:flag) { |language| image_tag(language.flag.url(:original)) if language.flag? }

    column :appears_in_backoffice
    column :appears_in_web
    column :default

    actions defaults: true do |language|
      link_to 'Set', change_locale_path(language.locale)
    end
  end

  filter :locale
  filter :name
  filter :appears_in_backoffice
  filter :appears_in_web

  form do |f|
    f.inputs 'Language Details' do
      f.input :locale
      f.input :name
      f.input :flag, hint: (image_tag(f.object.flag.url(:original)) if f.object.flag?)
      f.input :appears_in_backoffice
      f.input :appears_in_web
      f.input :default
    end
    f.actions
  end
end
