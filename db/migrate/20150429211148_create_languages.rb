class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :code
      t.string :flag
      t.boolean :appears_in_backoffice
      t.boolean :appears_in_web

      t.timestamps
    end
  end
end
