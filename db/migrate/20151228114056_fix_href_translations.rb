class FixHrefTranslations < ActiveRecord::Migration
  def change
    Product.all.map(&:save)
    Category.all.map(&:save)
    Tag.all.map(&:save)
  end
end
