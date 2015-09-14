class AddTranslationCommerce < ActiveRecord::Migration
  def change
    add_column :commerces, :language_id, :integer, default: nil
  end
end
