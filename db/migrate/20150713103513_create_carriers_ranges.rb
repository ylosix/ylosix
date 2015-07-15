class CreateCarriersRanges < ActiveRecord::Migration
  def change
    create_table :carriers_ranges do |t|
      t.references :zone, index: true, foreign_key: true
      t.references :carrier, index: true, foreign_key: true
      t.decimal :greater_equal_than
      t.decimal :lower_than
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
