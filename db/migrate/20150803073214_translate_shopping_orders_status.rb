class TranslateShoppingOrdersStatus < ActiveRecord::Migration
  def change
    add_column :shopping_orders_statuses, :color, :string

    ShoppingOrdersStatus.create_translation_table! :name => :string
  end
end
