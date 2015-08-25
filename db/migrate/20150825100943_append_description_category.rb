class AppendDescriptionCategory < ActiveRecord::Migration
  def change
    add_column :category_translations, :description, :text
  end
end
