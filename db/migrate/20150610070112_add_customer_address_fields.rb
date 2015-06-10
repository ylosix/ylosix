class AddCustomerAddressFields < ActiveRecord::Migration
  def change
    add_column :customer_addresses, :customer_id, :integer, index: true
    add_column :customer_addresses, :default_shipping, :boolean, null: false, default: false
    add_column :customer_addresses, :default_billing, :boolean, null: false, default: false

    add_foreign_key :customer_addresses, :customers, on_update: :cascade, on_delete: :cascade
  end
end
