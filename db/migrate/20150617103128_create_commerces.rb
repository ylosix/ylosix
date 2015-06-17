class CreateCommerces < ActiveRecord::Migration
  def change
    create_table :commerces do |t|
      t.string :http
      t.string :name
      t.string :meta_keywords
      t.string :meta_description
      t.references :template, index: true
      t.boolean :default

      t.timestamps null: false
    end

    add_column :commerces, :billing_address, :hstore
    add_foreign_key :commerces, :templates, on_update: :cascade, on_delete: :cascade
    add_attachment :commerces, :logo
  end
end
