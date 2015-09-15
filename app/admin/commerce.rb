ActiveAdmin.register Commerce do
  menu parent: 'Preferences'
  permit_params :default, :language_id, :no_redirect_shopping_cart, :http, :logo,
                :order_prefix, :meta_keywords, :meta_description,
                :ga_account_id, :name, :template_id, :address_1, :address_2,
                :postal_code, :city, :country, :phone, :cif, :social_networks

  index do
    selectable_column
    id_column

    column :default
    column :http
    column :language
    column (:logo) { |commerce| image_tag(commerce.logo.url(:original)) if commerce.logo? }
    column :ga_account_id
    column :name
    column :template
    actions
  end

  form do |f|
    f.inputs 'Commerce details' do
      f.input :name
      f.input :default
      f.input :no_redirect_shopping_cart
      f.input :http
      f.input :language
      f.input :social_networks
    end

    f.inputs 'Seo & Google analytics' do
      f.input :meta_keywords
      f.input :meta_description
      f.input :ga_account_id
    end

    f.inputs 'Design' do
      f.input :template

      f.inputs 'Dimensions 300x100' do
        f.input :logo, hint: (image_tag(commerce.logo.url(:original)) if commerce.logo?)
      end
    end

    f.inputs 'Billing address' do
      f.input :order_prefix, hint: 'Variables => %Y: year, %order_num: #order'
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

  controller do
    def update
      super

      @commerce[:social_networks] = {}
      JSON.parse(params[:commerce][:social_networks].to_s.gsub('=>', ':')).each do |k, v|
        @commerce[:social_networks][k] = v
      end

      @commerce.save
    end
  end
end
