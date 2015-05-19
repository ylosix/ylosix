class AddTaxToProduct < ActiveRecord::Migration
  def change
    rename_column :products, :tax_percent, :tax_id
    change_column :products, :tax_id, :integer
    add_index :products, :tax_id

    add_foreign_key :products, :taxes, on_delete: :cascade, on_update: :cascade
  end
end
