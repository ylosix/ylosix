class NewHref < ActiveRecord::Migration
  def change
    Product.all.map(&:save)
    Category.all.map(&:save)
  end
end
