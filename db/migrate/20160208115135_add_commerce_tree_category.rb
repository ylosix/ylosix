class AddCommerceTreeCategory < ActiveRecord::Migration
  def change
    add_column :commerces, :tree_category_id, :integer, index: true
  end
end
