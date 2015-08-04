ActiveAdmin.register ShoppingOrder do
  menu parent: 'Orders'

  permit_params :order_num, :carrier_id, :carrier_retail_price, :commerce_id, :customer_id, :shopping_orders_status_id

  index do
    selectable_column
    id_column
    column :retrieve_order_num
    column :customer
    column :total_products
    column :total_retail_price
    column :carrier
    column (:shopping_orders_status) do |so|
      if so.shopping_orders_status.nil?
        span 'pending', class: 'status_tag'
      else
        span so.shopping_orders_status.name,
             class: 'status_tag',
             style: "background-color: #{so.shopping_orders_status.color}"
      end
    end

    column :created_at
    actions
  end

  show title: proc { |so| "Shopping order ##{so.id}" } do
    attributes_table do
      row :id
      row :retrieve_order_num
      row 'Invoice' do |so|
        columns do
          column do
            link_to 'Generate', admin_invoice_shopping_order_path(so.id), target: '_blank'
          end
        end
      end

      row :customer
      row 'Products' do |so|
        table_for so.shopping_orders_products_plus_carrier do
          column :product
          column :quantity
          column :retail_price_pre_tax
          column :tax_rate
          column :retail_price
        end
      end

      row :total_products
      row :total_weight
      row :total_retail_price_pre_tax
      row :total_taxes
      row :total_retail_price

      row 'Addresses' do |so|
        columns do
          column do
            span '<b>Shipping address</b>'.html_safe

            saddress = so.shipping_address
            address_array = admin_retrieve_array_address(saddress)

            div [address_array].join(' <br/> ').html_safe
          end

          column do
            span '<b>Billing address</b>'.html_safe
            baddress = so.billing_address
            address_array = admin_retrieve_array_address(baddress)

            div [address_array].join(' <br/> ').html_safe
          end

          column do
            span '<b>Billing commerce</b>'.html_safe
            baddress = so.billing_commerce
            address_array = admin_retrieve_array_address(baddress)

            div [address_array].join(' <br/> ').html_safe
          end
        end
      end

      row :carrier
      row :shopping_order_status
      row :commerce
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Shopping order details' do
      f.input :order_num
      f.input :carrier
      f.input :carrier_retail_price
      f.input :commerce
      f.input :customer
      f.input :shopping_orders_status
    end

    f.actions
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
