ActiveAdmin.register Commerce do
  menu parent: 'Preferences'
  permit_params :billing_address, :default, :http, :logo, :meta_keywords, :meta_description, :name, :template_id

  index do
    selectable_column
    id_column

    column :default
    column :http
    column (:logo) { |commerce| image_tag(commerce.logo.url(:original))  if commerce.logo? }
    column :meta_keywords
    column :meta_description
    column :name
    column :template_id
    actions
  end

  form do |f|
    f.inputs 'Commerce details' do
      f.input :default
      f.input :http
      f.input :logo, hint: (f.template.image_tag(commerce.logo.url(:original)) if commerce.logo?)
      f.input :meta_keywords
      f.input :meta_description
      f.input :name
      f.input :template
    end

    f.actions
  end
end
