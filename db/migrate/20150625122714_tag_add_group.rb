class TagAddGroup < ActiveRecord::Migration
  def change
    rename_column :tags, :parent_id, :tags_group_id
    # add_index :tags, :tags_group_id
  end
end
