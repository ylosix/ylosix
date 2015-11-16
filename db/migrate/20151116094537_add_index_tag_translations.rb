class AddIndexTagTranslations < ActiveRecord::Migration
  def change
    add_index :tag_translations, :slug
  end
end
