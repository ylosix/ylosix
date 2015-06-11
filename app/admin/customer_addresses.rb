ActiveAdmin.register CustomerAddress do
  menu parent: 'Customers'

  permit_params :customer_id, :default_billing, :default_shipping, :name

  index do
    selectable_column
    id_column

    column :customer
    column :fields
    column :default_billing
    column :default_shipping
    column :created_at
    column :updated_at
    actions
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
