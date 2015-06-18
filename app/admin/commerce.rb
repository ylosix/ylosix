ActiveAdmin.register Commerce do
  menu parent: 'Preferences'
  permit_params :default, :http, :logo, :meta_keywords, :meta_description, :name, :template_id,
                :name, :address_1, :address_2, :postal_code, :city, :country, :phone, :cif

  index do
    selectable_column
    id_column

    column :default
    column :http
    column (:logo) { |commerce| image_tag(commerce.logo.url(:original)) if commerce.logo? }
    column :meta_keywords
    column :meta_description
    column :name
    column :template
    actions
  end

  form do |f|
    f.inputs 'Commerce details' do
      f.input :name
      f.input :default
      f.input :http

      f.input :meta_keywords
      f.input :meta_description
    end

    f.inputs 'Design' do
      f.input :template

      f.inputs 'Dimensions 300x100' do
        f.input :logo, hint: (f.template.image_tag(commerce.logo.url(:original)) if commerce.logo?)
      end
    end

    f.inputs 'Billing address' do
      f.input :name
      f.input :address_1
      f.input :address_2
      f.input :postal_code
      f.input :city
      f.input :country
      f.input :phone
      f.input :cif
    end

    f.actions
  end
end
