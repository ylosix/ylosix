class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.integer :priority

      t.timestamps null: false
    end

    add_column :product_translations, :features, :hstore
  end
end
