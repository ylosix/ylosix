ActiveAdmin.register ShoppingCart do
  menu parent: 'Customers'

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
