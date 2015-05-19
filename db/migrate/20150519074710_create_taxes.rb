class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.string :name
      t.decimal :rate, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
