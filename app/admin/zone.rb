# == Schema Information
#
# Table name: zones
#
#  code       :string
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  updated_at :datetime         not null
#

ActiveAdmin.register Zone do
  menu parent: 'Locales', if: proc { my_site && my_site.enable_commerce_options }

  permit_params :name, :code

  index do
    selectable_column
    id_column
    column :name
    column :code

    actions
  end

  filter :code
  filter :name

  form do |f|
    f.inputs 'Country Details' do
      f.input :code
      f.input :name
    end
    f.actions
  end
end
