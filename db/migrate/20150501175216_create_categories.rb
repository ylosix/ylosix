class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :name
      t.boolean :enabled, :default => false
      t.boolean :appears_in_web, :default => true
      t.string :meta_title
      t.string :meta_description
      t.string :slug

      t.timestamps null: false
    end

    add_index :categories, :parent_id
    add_index :categories, :slug
  end
end
