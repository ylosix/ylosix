ActiveAdmin.register Product do
  permit_params :reference_code, :name, :enabled, :appears_in_categories, :appears_in_tag, :appears_in_search,
  :short_description, :description, :publication_date, :unpublication_date, :retail_price_pre_tax, :retail_price,
  :tax_percent, :meta_title, :meta_description, :slug, :stock, :control_stock

  index do
    selectable_column
    id_column
    column :reference_code
    column :name
    column :enabled
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Admin Details' do
      f.input :reference_code
      f.input :name
      f.input :enabled
      f.input :appears_in_categories
      f.input :appears_in_tag
      f.input :appears_in_search
      f.input :short_description
      f.input :description
      f.input :publication_date
      f.input :unpublication_date
      f.input :retail_price_pre_tax
      f.input :retail_price
      f.input :tax_percent
      f.input :meta_title
      f.input :meta_description
      f.input :slug
      f.input :stock
      f.input :control_stock
    end
    f.actions
  end

end
