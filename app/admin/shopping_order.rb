ActiveAdmin.register ShoppingOrder do
  menu parent: 'Orders'

  # permit_params :email, :name, :last_name, :birth_date

  index do
    selectable_column
    id_column
    column :customer
    column :total_products
    column :total_retail_price
    column :created_at
    column :updated_at
    actions
  end

  def retrieve_array_address(caddress)
    address_array = []

    address_array << "#{caddress[:customer_name]} #{caddress[:customer_last_name]}"
    address_array << caddress[:dni]
    address_array << caddress[:business]
    address_array << caddress[:address_1]
    address_array << caddress[:address_2] unless caddress[:address_2].blank?
    address_array << "#{caddress[:postal_code]} #{caddress[:city]}"
    address_array << caddress[:country]
    address_array << caddress[:phone]
    address_array << caddress[:mobile_phone]
    address_array << caddress[:other]

    address_array
  end

  show title: proc { |so| "Shopping order ##{so.id}" } do
    attributes_table do
      row :id
      row 'Invoice' do |so|
        columns do
          column do
            link_to 'Generate', admin_invoice_shopping_order_path(so.id), target: '_blank'
          end
        end
      end

      row :customer
      row 'Products' do |so|
        table_for so.shopping_orders_products do
          column :product
          column :quantity
          column :retail_price_pre_tax
          column :tax_rate
          column :retail_price
        end
      end

      row :total_products
      row :total_retail_price_pre_tax
      row :total_taxes
      row :total_retail_price

      row 'Addresses' do |so|
        columns do
          column do
            span '<b>Shipping address</b>'.html_safe

            saddress = so.shipping_address
            address_array = retrieve_array_address(saddress)

            div [address_array].join(' <br/> ').html_safe
          end

          column do
            span '<b>Billing address</b>'.html_safe
            baddress = so.shipping_address
            address_array = retrieve_array_address(baddress)

            div [address_array].join(' <br/> ').html_safe
          end

          column do
            span '<b>Billing commerce</b>'.html_safe
            baddress = so.billing_commerce
            address_array = retrieve_array_address(baddress)

            div [address_array].join(' <br/> ').html_safe
          end
        end
      end

      row :created_at
      row :updated_at
    end
  end

  controller do
    def invoice
      render layout: '/layouts/invoice', partial: '/shopping_orders/invoice', locals: {shopping_order: resource}
    end
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
