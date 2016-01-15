class EnableCommerce < ActiveRecord::Migration
  def change
    add_column :commerces, :enable_commerce_options, :boolean, default: false, null: false
  end
end
