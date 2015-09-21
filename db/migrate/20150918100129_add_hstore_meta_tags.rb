class AddHstoreMetaTags < ActiveRecord::Migration
  def set_meta_hash(array)
    array.each do |elem|
      elem.meta_tags['description'] = elem.meta_description
      elem.meta_tags['keywords'] = elem.meta_keywords
      elem.save
    end
  end

  def change
    add_column :commerces, :meta_tags, :hstore, null: false, default: {}
    add_column :product_translations, :meta_tags, :hstore, null: false, default: {}
    add_column :category_translations, :meta_tags, :hstore, null: false, default: {}

    set_meta_hash(Commerce.all)

    remove_column :commerces, :meta_keywords
    remove_column :commerces, :meta_description

    remove_column :products, :meta_description
    remove_column :products, :meta_keywords

    remove_column :categories, :meta_description
    remove_column :categories, :meta_keywords
  end
end
