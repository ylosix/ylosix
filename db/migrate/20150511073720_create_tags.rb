class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.integer :parent_id
      t.integer :priority, default: 1
      t.boolean :appears_in_web

      t.timestamps null: false
    end

    add_index :tags, :parent_id
  end
end
