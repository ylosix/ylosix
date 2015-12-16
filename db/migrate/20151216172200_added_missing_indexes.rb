class AddedMissingIndexes < ActiveRecord::Migration
  def change
    add_index :commerces, :default
    add_index :commerces, :http
    add_index :commerces, [:default, :http]

    add_index :languages, :default
    add_index :languages, [:locale, :appears_in_web]

    add_index :categories, :enabled
    add_index :templates, :enabled
    add_index :carriers, :enabled

    add_index :products, :enabled
    add_index :products, :visible

    add_index :countries, :enabled
    add_index :countries, :code

    add_index :customer_addresses, :customer_id
  end
end
