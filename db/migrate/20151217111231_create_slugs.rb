class CreateSlugs < ActiveRecord::Migration
  def change
    create_table :slugs do |t|
      t.string :class_name,   null: false, index: true
      t.integer :object_id,   null: false, index: true
      t.string :slug,         null: false, index: true, unique: true
      t.string :locale,       null: false

      t.timestamps null: false
    end
  end
end
