class AddPriorityCategory < ActiveRecord::Migration
  def change
    add_column :categories, :priority, :integer, default: 1, null: false

    change_column :features, :priority, :integer, default: 1, null: false
    change_column :tags, :priority, :integer, default: 1, null: false
  end
end
