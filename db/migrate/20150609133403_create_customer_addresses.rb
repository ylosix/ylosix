class CreateCustomerAddresses < ActiveRecord::Migration
  def change
    create_table :customer_addresses do |t|
      t.string :name

      t.timestamps null: false
    end

    add_column :customer_addresses, :fields, :hstore, default: {}, null: false
  end
end
