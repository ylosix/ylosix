class AddCarrierShoppingCart < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :carrier_id, :integer
  end
end
