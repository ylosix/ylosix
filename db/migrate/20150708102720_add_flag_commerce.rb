class AddFlagCommerce < ActiveRecord::Migration
  def change
    add_column :commerces, :no_redirect_shopping_cart, :boolean, null: false, default: false
  end
end
