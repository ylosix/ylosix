class FixEnabledAndVisible < ActiveRecord::Migration
  def change
    rename_column :categories, :appears_in_web, :visible
    rename_column :products, :appears_in_categories, :visible

    remove_column :products, :appears_in_search
    remove_column :products, :appears_in_tag

    remove_column :tags, :appears_in_web
  end
end
