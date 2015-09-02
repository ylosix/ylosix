class AddSlugTranslations < ActiveRecord::Migration
  def change
    add_column :product_translations, :slug, :string
    add_column :tag_translations, :slug, :string

    Category.all.each do |object|
      object.category_translations.each do |translation|
        translation.update_attribute(:slug, object.slug)
      end
    end

    Product.all.each do |object|
      object.product_translations.each do |translation|
        translation.update_attribute(:slug, object.slug)
      end
    end

    Tag.all.each do |object|
      object.tag_translations.each do |translation|
        translation.update_attribute(:slug, object.slug)
      end
    end

    remove_column :products, :slug
    remove_column :tags, :slug
    rename_column :categories, :slug, :reference_code
  end
end
