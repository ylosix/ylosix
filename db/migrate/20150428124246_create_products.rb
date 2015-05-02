class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :reference_code
      t.string :name
      t.string :barcode
      t.boolean :enabled

      t.boolean :appears_in_categories
      t.boolean :appears_in_tag
      t.boolean :appears_in_search

      t.string :short_description
      t.text :description
      t.timestamp :publication_date
      t.timestamp :unpublication_date

      t.decimal :retail_price_pre_tax, :precision => 10, :scale => 5
      t.decimal :retail_price, :precision => 10, :scale => 2
      t.decimal :tax_percent, :precision => 3, :scale => 2

      t.string :meta_title
      t.string :meta_description
      t.string :slug

      t.integer :stock
      t.boolean :control_stock

      t.timestamps
    end

    add_attachment :products, :image
  end
end
