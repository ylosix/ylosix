class AddCommercePerPage < ActiveRecord::Migration
  def change
    add_column :commerces, :per_page, :integer, default: 20, nil: false
  end
end
