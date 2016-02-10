# == Schema Information
#
# Table name: shopping_carts
#
#  billing_address_id   :integer
#  carrier_id           :integer
#  carrier_retail_price :decimal(10, 2)   default(0.0), not null
#  created_at           :datetime         not null
#  customer_id          :integer
#  extra_fields         :hstore           default({}), not null
#  id                   :integer          not null, primary key
#  shipping_address_id  :integer
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_shopping_carts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_7725ef05cb  (billing_address_id => customer_addresses.id)
#  fk_rails_95c2cdac1a  (shipping_address_id => customer_addresses.id)
#  fk_rails_a4cc6e935e  (customer_id => customers.id)
#

ActiveAdmin.register ShoppingCart do
  menu parent: 'Orders', priority: 4, if: proc { commerce && commerce.enable_commerce_options }

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

  form do |f|
    f.inputs 'Shopping cart details' do
      f.input :billing_address
      f.input :shipping_address
      f.input :carrier
      f.input :carrier_retail_price
      f.input :customer

      f.input :extra_fields, as: :text
    end

    f.actions
  end

  show title: proc { |so| "Shopping cart ##{so.id}" } do |_so|
    attributes_table do
      row :id
      row :customer

      row 'Products' do |so|
        table_for so.shopping_carts_products do
          column :product
          column :quantity
          column :retail_price
        end
      end

      row :total_products
      row :total_weight
      row :total_retail_price

      row :created_at
      row :updated_at
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
