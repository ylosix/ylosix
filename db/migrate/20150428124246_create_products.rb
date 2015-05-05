class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :reference_code
      t.string :name
      t.string :barcode
      t.boolean :enabled, :default => false

      t.boolean :appears_in_categories, :default => true
      t.boolean :appears_in_tag, :default => true
      t.boolean :appears_in_search, :default => true

      t.string :short_description
      t.text :description
      t.timestamp :publication_date, :null => false, :default => '2015-01-01 00:00:00'
      t.timestamp :unpublication_date, :default => nil

      t.decimal :retail_price_pre_tax, precision: 10, scale: 5
      t.decimal :retail_price, precision: 10, scale: 2
      t.decimal :tax_percent, precision: 5, scale: 2

      t.string :meta_title
      t.string :meta_description
      t.string :slug

      t.integer :stock, :default => 0
      t.boolean :control_stock, :default => false

      t.timestamps
    end

    add_attachment :products, :image
  end
end
