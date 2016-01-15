# == Schema Information
#
# Table name: taxes
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  name       :string
#  rate       :decimal(5, 2)
#  updated_at :datetime         not null
#

ActiveAdmin.register Tax do
  menu parent: 'Locales', if: proc { commerce && commerce.enable_commerce_options }

  permit_params :name, :rate

  index do
    selectable_column
    id_column
    column :name
    column :rate
    actions
  end

  filter :name
  filter :rate

  form do |f|
    f.inputs 'Tax Details' do
      f.input :name
      f.input :rate
    end
    f.actions
  end
end
