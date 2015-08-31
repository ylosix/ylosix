class AddShortDescriptionCategory < ActiveRecord::Migration
  def change
    add_column :category_translations, :short_description, :text
    add_column :category_translations, :slug, :string
  end
end
