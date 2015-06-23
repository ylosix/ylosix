class AddOrderNum < ActiveRecord::Migration
  def change
    add_column :shopping_orders, :order_num, :integer

    ShoppingOrder.update_all(:order_num => 0)

    execute 'CREATE SEQUENCE order_num_seq;'
    execute "ALTER TABLE shopping_orders ALTER order_num SET DEFAULT NEXTVAL('order_num_seq'::regclass);"

    change_column :shopping_orders, :order_num, :integer, null: false
    add_column :commerces, :order_prefix, :string, default: '', null: false
  end
end
