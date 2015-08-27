class AddDesignViewCategoryProduct < ActiveRecord::Migration
  def change
    add_column :categories, :show_action_name, :string, default: nil
    add_column :products, :show_action_name, :string, default: nil
  end
end
