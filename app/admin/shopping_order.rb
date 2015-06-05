ActiveAdmin.register ShoppingOrder do
  menu parent: 'Orders'

  # permit_params :email, :name, :last_name, :birth_date

  index do
    selectable_column
    id_column
    column :customer
    column :total
    column :created_at
    column :updated_at
    actions
  end

  show title: proc { |so| "Shopping order ##{so.id}" } do |_so|
    attributes_table do
      row :id
      row :customer

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
