class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :name
      t.boolean :appears_in_web
      t.string :meta_title
      t.string :meta_description
      t.string :slug

      t.timestamps null: false
    end
  end
end
