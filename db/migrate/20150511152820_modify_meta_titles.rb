class ModifyMetaTitles < ActiveRecord::Migration
  def change
    rename_column :products, :meta_title, :meta_keywords
    rename_column :categories, :meta_title, :meta_keywords
  end
end
