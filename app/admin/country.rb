# == Schema Information
#
# Table name: countries
#
#  code       :string
#  created_at :datetime         not null
#  enabled    :boolean          default(FALSE), not null
#  id         :integer          not null, primary key
#  iso        :string
#  name       :string
#  updated_at :datetime         not null
#  zone_id    :integer
#
# Indexes
#
#  index_countries_on_code     (code)
#  index_countries_on_enabled  (enabled)
#  index_countries_on_zone_id  (zone_id)
#
# Foreign Keys
#
#  fk_rails_e12271a270  (zone_id => zones.id)
#

ActiveAdmin.register Country do
  menu parent: 'Locales', if: proc { my_site && my_site.enable_commerce_options }

  permit_params :zone_id, :name, :iso, :enabled, :code

  index do
    selectable_column
    id_column
    column :zone
    column :code
    column :name
    column :iso
    column :enabled

    actions
  end

  filter :zone
  filter :code
  filter :name
  filter :iso
  filter :enabled

  form do |f|
    f.inputs 'Country Details' do
      f.input :zone
      f.input :code
      f.input :name
      f.input :iso
      f.input :enabled
    end
    f.actions
  end
end
