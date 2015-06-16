ActiveAdmin.register Product do
  menu parent: 'Catalog'

  permit_params :reference_code, :name, :enabled, :appears_in_categories,
                :appears_in_tag, :appears_in_search, :short_description,
                :description, :publication_date, :unpublication_date,
                :retail_price_pre_tax, :retail_price, :tax_id, :image,
                :meta_keywords, :meta_description, :slug, :stock, :control_stock,
                products_categories_attributes: [:id, :category_id, :product_id, :_destroy],
                product_translations_attributes: [:id, :locale, :name, :short_description, :description],
                products_pictures_attributes: [:id, :image, :_destroy]

  index do
    selectable_column
    id_column
    column :reference_code
    column (:image) { |product| image_tag(product.retrieve_main_image(:thumbnail)) }
    column :name
    column :enabled
    column :created_at
    actions
  end

  filter :reference_code
  filter :translations_name, as: :string, label: 'Name'
  filter :enabled

  form do |f|
    f.inputs 'Information' do
      translations = Utils.array_translations(ProductTranslation, product_id: product.id)
      admin_translation_text_field(translations, 'product', 'name')
      f.input :reference_code

      f.input :enabled
      f.input :appears_in_categories
      f.input :appears_in_tag
      f.input :appears_in_search

      admin_translation_text_field(translations, 'product', 'short_description', ActiveAdminHelpers::TEXT_AREA)
      admin_translation_text_field(translations, 'product', 'description', ActiveAdminHelpers::CKEDITOR)

      f.input :publication_date
      f.input :unpublication_date
    end

    f.inputs 'Price' do
      f.input :retail_price_pre_tax, input_html: {onchange: 'javascript:change_price_pre_tax(this);'}
      f.input :retail_price, input_html: {onchange: 'javascript:change_price(this);'}

      taxes = Tax.all
      render partial: 'admin/products/taxes', locals: {taxes: taxes, tax: product.tax}
    end

    f.inputs 'Seo' do
      f.input :meta_keywords
      f.input :meta_description
      f.input :slug
    end

    f.inputs 'Images' do
      f.input :image, hint: (f.template.image_tag(product.image.url(:thumbnail)) if product.image?)

      f.has_many :products_pictures, allow_destroy: true do |s|
        s.input :image, as: :file, hint: f.template.image_tag(s.object.image.url), allow_destroy: true
      end
    end

    f.inputs 'Association' do
      # f.has_many :products_categories, allow_destroy: true do |s|
      #   s.input :category
      # end

      # f.has_many :products_tags, allow_destroy: true do |s|
      #   s.input :tag
      # end

      render partial: 'admin/products/categories', locals:
                                                     {
                                                         products_categories: product.products_categories,
                                                         root_category: Category.root_category
                                                     }

      render partial: 'admin/products/tags', locals:
                                               {
                                                   products_tags: product.products_tags,
                                                   root_tags: Tag.root_tags
                                               }
    end

    f.inputs 'Stock' do
      f.input :stock
      f.input :control_stock
    end

    f.actions
  end

  # Clone product
  action_item :view, only: :show do
    link_to('Clone Product', admin_clone_product_path(product))
  end

  controller do
    def new
      unless params[:id].blank? # if id is passed (i.e. /product/25/new), evaluate below code before rendering new form
        product = Product.find(params[:id])
        @product = product.clone
      end

      super
    end

    def create
      super

      update_categories
      update_tags
    end

    def update
      super

      update_categories
      update_tags
    end

    private

    def update_categories
      unless params[:product][:products_categories_ids].blank?
        product = resource
        categories = params[:product][:products_categories_ids]
        ProductsCategory.where(product: product).destroy_all(['category_id NOT IN (?)', categories])

        categories.each do |category|
          ProductsCategory.find_or_create_by(product_id: product.id, category_id: category)
        end
      end
    end

    def update_tags
      unless params[:product][:products_tags_ids].blank?
        product = resource
        tags = params[:product][:products_tags_ids]
        ProductsTag.where(product: product).destroy_all(['tag_id NOT IN (?)', tags])

        tags.each do |tag|
          ProductsTag.find_or_create_by(product_id: product.id, tag_id: tag)
        end
      end
    end
  end
end
