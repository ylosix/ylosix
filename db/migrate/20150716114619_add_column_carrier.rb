class AddColumnCarrier < ActiveRecord::Migration
  def change
    add_column :shopping_orders, :carrier_id, :integer
    add_foreign_key :shopping_orders, :carriers, on_update: :cascade, on_delete: :cascade
  end
end
