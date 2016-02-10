# == Schema Information
#
# Table name: customers
#
#  birth_date             :date
#  created_at             :datetime         not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  enabled                :boolean
#  encrypted_password     :string           default(""), not null
#  id                     :integer          not null, primary key
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locale                 :string           default("en"), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_customers_on_email                 (email) UNIQUE
#  index_customers_on_reset_password_token  (reset_password_token) UNIQUE
#

ActiveAdmin.register Customer do
  menu parent: 'Orders', priority: 1, if: proc { commerce && commerce.enable_commerce_options }

  permit_params :email, :locale, :name, :last_name, :birth_date

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :last_name
    column :locale
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :locale
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show title: proc { |c| "#{c.name}" } do
    attributes_table do

      row :id
      row :email
      row :name
      row :last_name
      row :birth_date
      row :enabled
      row :locale

      row :current_sign_in_at
      row :sign_in_count
      row :last_sign_in_at

      row :created_at
      row :updated_at

      row t('activerecord.models.customer_address.other') do |c|
        table_for c.customer_addresses do

          column (:name) { |address| auto_link(address, address.name) }
          column :default_billing
          column :default_shipping
          column (:fields) do |address|
            address_array = admin_retrieve_array_address(address.fields)

            div address_array.join(' <br/> ').html_safe
          end

          column :created_at
        end
      end
    end
  end
end
