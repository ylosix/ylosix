class AddLinksPath < ActiveRecord::Migration
  def change
    add_column :links, :href, :string
    add_column :products, :href_translations, :hstore, null: false, default: {}
    add_column :categories, :href_translations, :hstore, null: false, default: {}
    add_column :tags, :href_translations, :hstore, null: false, default: {}

    Product.all.map(&:save)
    Category.all.map(&:save)
    Tag.all.map(&:save)
  end
end
