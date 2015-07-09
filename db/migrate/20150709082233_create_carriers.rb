class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.string :delay
      t.boolean :enabled, null: false, default: false
      t.boolean :free_carrier, null: false, default: false
      t.integer :priority, null: false, default: 1

      t.timestamps null: false
    end

    add_attachment :carriers, :image
    Carrier.create_translation_table! name: :string, delay: :string
  end
end
