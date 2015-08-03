class CreateShoppingOrdersStatuses < ActiveRecord::Migration
  def change
    create_table :shopping_orders_statuses do |t|
      t.string :name
      t.boolean :enable_invoice

      t.timestamps null: false
    end
    
    add_column :shopping_orders, :shopping_orders_status_id, :integer, default: nil
  end
end
