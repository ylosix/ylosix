class CreateTagsGroupsCategories < ActiveRecord::Migration
  def change
    create_table :tags_groups_categories do |t|
      t.references :category, index: true, foreign_key: true
      t.references :tags_group, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
