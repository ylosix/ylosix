ActiveAdmin.register CustomerAddress do
  menu parent: 'Customers'

  permit_params :customer_id, :default_billing, :default_shipping, :name,
                :customer_name, :customer_last_name, :business, :address_1,
                :address_2, :postal_code, :city, :country, :phone,
                :mobile_phone, :dni, :other

  index do
    selectable_column
    id_column

    column :customer
    column 'Fields' do |caddress|
      address_array = []
      address_array << "#{caddress.customer_name} #{caddress.customer_last_name}"
      address_array << caddress.dni
      address_array << caddress.business
      address_array << caddress.address_1
      address_array << caddress.address_2 unless caddress.address_2.blank?
      address_array << "#{caddress.postal_code} #{caddress.city}"
      address_array << caddress.country
      address_array << caddress.phone
      address_array << caddress.mobile_phone
      address_array << caddress.other

      [address_array].join(' <br/> ').html_safe
    end

    column :default_billing
    column :default_shipping
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs 'Customer Details' do
      f.input :default_billing
      f.input :default_shipping

      f.input :name
      f.input :customer_name
      f.input :customer_last_name
      f.input :business
      f.input :address_1
      f.input :address_2
      f.input :postal_code
      f.input :city
      f.input :country
      f.input :phone
      f.input :mobile_phone
      f.input :dni
      f.input :other
    end

    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
end
