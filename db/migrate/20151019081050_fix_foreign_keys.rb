class FixForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key :tags_groups_categories, :categories
    remove_foreign_key :tags_groups_categories, :tags_groups

    add_foreign_key :tags_groups_categories, :categories, on_delete: :cascade, on_update: :cascade
    add_foreign_key :tags_groups_categories, :tags_groups, on_delete: :cascade, on_update: :cascade
  end
end
