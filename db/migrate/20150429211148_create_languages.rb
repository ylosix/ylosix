class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :code
      t.boolean :appears_in_backoffice, :default => false
      t.boolean :appears_in_web, :default => false

      t.timestamps
    end

    add_attachment :languages, :flag

    add_index :languages, :code
  end
end
