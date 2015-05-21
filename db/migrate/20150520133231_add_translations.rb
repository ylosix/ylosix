class AddTranslations < ActiveRecord::Migration
  def up
    Category.create_translation_table! :name => :string
    Product.create_translation_table! :name => :string, :short_description => :text, :description => :text
    Tag.create_translation_table! :name => :string
  end

  def down
    Category.drop_translation_table!
    Product.drop_translation_table!
    Tag.drop_translation_table!
  end
end
