class RemoveShoppingOrderStatuses < ActiveRecord::Migration
  def change
    remove_column :shopping_orders_statuses, :name
    add_column :shopping_orders_statuses, :name_translations, :hstore, null: false, default: {}

    ShoppingOrdersStatusTranslation.all.each do |t|
      object = t.shopping_orders_status

      object.name_translations[t.locale.to_sym] = t.name
      object.save
    end
  end
end
