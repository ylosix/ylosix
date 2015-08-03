ActiveAdmin.register ShoppingOrdersStatus do
  menu parent: 'Orders'

  index do
    selectable_column
    id_column
    column (:name) { |status| span status.name, class: 'status_tag', style: "background-color: #{status.color}" }
    column :enable_invoice
    actions
  end

  # permit_params :email, :name, :last_name, :birth_date

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
