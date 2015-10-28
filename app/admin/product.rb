ActiveAdmin.register Product do
  menu parent: 'Catalog'

  permit_params do
    permitted = [:reference_code, :name, :enabled, :visible, :short_description,
                 :description, :publication_date, :unpublication_date,
                 :retail_price_pre_tax, :retail_price, :tax_id, :image,
                 :width, :height, :depth, :weight,
                 :meta_keywords, :meta_description, :show_action_name,
                 :stock, :control_stock,
                 products_categories_attributes: [:id, :category_id, :product_id, :_destroy],
                 products_pictures_attributes: [:id, :image, :_destroy]]

    pta = [:id, :locale, :name, :short_description, :description, :slug]

    features = []
    Feature.all.each do |feature|
      features << feature.id.to_s.to_sym
    end
    pta << {features: features}

    if !params[:product].blank? && !params[:product][:product_translations_attributes].blank?
      unless params[:product][:product_translations_attributes]['0'][:meta_tags].blank?
        meta_tags = params[:product][:product_translations_attributes]['0'][:meta_tags].keys
        pta << {meta_tags: meta_tags}
      end
    end

    permitted << {product_translations_attributes: pta}
    permitted
  end

  action_item :view, only: :show do
    link_to(t('formtastic.clone', model: t('activerecord.models.product.one')), admin_clone_product_path(product))
  end

  action_item :view, only: :show do
    link_to(t('formtastic.add_another', model: t('activerecord.models.product.one')), new_admin_product_path)
  end

  action_item :view, only: [:show, :edit] do
    link_to 'Public link', product_path(product.slug), target: '_blank'
  end

  index do
    selectable_column
    id_column
    column :reference_code
    column (:image) { |product| image_tag(product.retrieve_image(:thumbnail)) }
    column :name
    column :enabled

    column (t('activerecord.models.category.other')) { |product| product.categories.map(&:name).join(', ') }
    column (:tags) { |product| product.tags.map(&:name).join(', ') }

    actions
  end

  show title: proc { |p| "Product ##{p.id}" } do
    attributes_table do
      row :id
      row :reference_code
      row :name
      row :barcode
      row :enabled
      row :visible
      row :short_description
      row :publication_date
      row :unpublication_date

      row :retail_price_pre_tax
      row :retail_price
      row :tax

      row 'Features' do
        table_for Feature.all do
          column :name
          column (:value) { |feature| product.features[feature.id.to_s] unless product.features.nil? }
        end
      end

      row :width
      row :height
      row :depth
      row :weight

      row :slug
      row :stock
      row :control_stock

      row :created_at
      row :updated_at
    end
  end

  filter :reference_code
  filter :translations_name, as: :string, label: proc { I18n.t 'activerecord.attributes.product.name' }

  filter :by_categorization_in,
         label: proc { I18n.t 'activerecord.models.category.one' },
         as: :select,
         collection: proc { Category.all }

  filter :by_tagging_in,
         label: proc { I18n.t 'activerecord.models.tag.one' },
         as: :select,
         collection: proc { Tag.all }

  filter :enabled

  form do |f|
    translations = Utils.array_translations(ProductTranslation,
                                            {product_id: product.id},
                                            meta_tags: {keywords: '', description: ''})

    tabs do
      tab 'Information' do
        f.inputs 'Information' do
          admin_translation_text_field(translations, 'product', 'name')
          f.input :reference_code

          f.input :enabled
          f.input :visible

          admin_translation_text_field(translations, 'product', 'short_description', component: ActiveAdminHelper::TEXT_AREA)
          admin_translation_text_field(translations, 'product', 'description', component: ActiveAdminHelper::CKEDITOR)

          f.input :publication_date
          f.input :unpublication_date
        end

        f.inputs 'Features' do
          render partial: 'admin/products/features', locals: {translations: translations,
                                                              features: Feature.all}
        end

        f.inputs 'Price' do
          f.input :retail_price_pre_tax, input_html: {onchange: 'javascript:change_price_pre_tax(this);'}
          f.input :retail_price, input_html: {onchange: 'javascript:change_price(this);'}

          taxes = Tax.all
          render partial: 'admin/products/taxes', locals: {taxes: taxes, tax: product.tax}
        end

        f.inputs 'Stock' do
          f.input :stock
          f.input :control_stock
        end
      end

      tab 'Association' do
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
                                                       tags_groups: TagsGroup.all
                                                   }
        end
      end

      tab 'Images' do
        f.inputs 'Images' do
          f.input :image, as: :file, hint: (image_tag(product.image.url(:thumbnail)) if product.image?)

          f.has_many :products_pictures, allow_destroy: true do |s|
            s.input :image, as: :file, hint: (image_tag(s.object.image.url(:thumbnail)) if s.object.image?), allow_destroy: true
          end
        end
      end

      tab 'Seo' do
        f.inputs 'Seo' do
          admin_translation_text_field(translations, 'product', 'meta_tags')
          admin_translation_text_field(translations, 'product', 'slug', hint: 'Chars not allowed: (Upper chars) spaces')
          f.input :show_action_name, hint: 'File name of show render'
        end
      end

      tab 'Transport' do
        f.inputs 'Transport' do
          f.input :width, hint: 'cm'
          f.input :height, hint: 'cm'
          f.input :depth, hint: 'cm'
          f.input :weight, hint: 'kg'
        end
      end
    end

    f.actions
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
      ProductsCategory.destroy_all(product: resource)

      unless params[:product][:products_categories_ids].blank?
        categories = params[:product][:products_categories_ids]

        categories.each do |category|
          ProductsCategory.find_or_create_by(product_id: resource.id, category_id: category)
        end
      end
    end

    def update_tags
      ProductsTag.destroy_all(product: resource)

      unless params[:product][:products_tags_ids].blank?
        tags = params[:product][:products_tags_ids]

        tags.each do |tag|
          ProductsTag.find_or_create_by(product_id: resource.id, tag_id: tag)
        end
      end
    end
  end
end
