# == Schema Information
#
# Table name: products
#
#  barcode                        :string
#  control_stock                  :boolean          default(FALSE)
#  created_at                     :datetime
#  depth                          :decimal(10, 6)   default(0.0), not null
#  description_translations       :hstore           default({}), not null
#  enabled                        :boolean          default(FALSE)
#  features_translations          :hstore           default({}), not null
#  height                         :decimal(10, 6)   default(0.0), not null
#  href_translations              :hstore           default({}), not null
#  id                             :integer          not null, primary key
#  image_content_type             :string
#  image_file_name                :string
#  image_file_size                :integer
#  image_updated_at               :datetime
#  meta_tags_translations         :hstore           default({}), not null
#  name_translations              :hstore           default({}), not null
#  publication_date               :datetime         not null
#  reference_code                 :string
#  retail_price                   :decimal(10, 2)   default(0.0), not null
#  retail_price_pre_tax           :decimal(10, 5)   default(0.0), not null
#  short_description_translations :hstore           default({}), not null
#  show_action_name               :string
#  slug_translations              :hstore           default({}), not null
#  stock                          :integer          default(0)
#  tax_id                         :integer
#  unpublication_date             :datetime
#  updated_at                     :datetime
#  visible                        :boolean          default(TRUE)
#  weight                         :decimal(10, 6)   default(0.0), not null
#  width                          :decimal(10, 6)   default(0.0), not null
#
# Indexes
#
#  index_products_on_enabled  (enabled)
#  index_products_on_tax_id   (tax_id)
#  index_products_on_visible  (visible)
#
# Foreign Keys
#
#  fk_rails_f5661f270e  (tax_id => taxes.id)
#

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

    features = Feature.pluck(:id).map { |id| id.to_s.to_sym }
    locales = Language.pluck(:locale).map(&:to_sym)
    permitted << {
        name_translations: locales,
        short_description_translations: locales,
        description_translations: locales,
        features_translations: locales.map { |locale| {locale => features} },
        slug_translations: locales,
        meta_tags_translations: locales
    }

    permitted
  end

  action_item :view, only: :show do
    link_to(t('formtastic.clone', model: t('activerecord.models.product.one')), admin_clone_product_path(product))
  end

  action_item :view, only: :show do
    link_to(t('formtastic.add_another', model: t('activerecord.models.product.one')), new_admin_product_path)
  end

  action_item :view, only: [:show, :edit] do
    link_to 'Public link', product_path(product), target: '_blank' if product
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

    actions defaults: true do |product|
      link_to t('formtastic.clone', model: ''), admin_clone_product_path(product), class: 'member_link clone_link'
    end
  end

  show title: proc { |p| "#{p.name}" } do
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

      row t('activerecord.models.feature.other') do
        table_for Feature.all do
          column :name
          column (:value) { |feature| JSON.parse(product.features.gsub('=>', ':'))[feature.id.to_s] unless product.features.nil? }
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
  filter :by_name_in,
         label: proc { I18n.t 'activerecord.attributes.product.name' },
         as: :string

  filter :by_categorization_in,
         label: proc { I18n.t 'activerecord.models.category.one' },
         as: :select,
         collection: proc { category_collection_select }

  filter :by_tagging_in,
         label: proc { I18n.t 'activerecord.models.tag.one' },
         as: :select,
         collection: proc { Tag.all }

  filter :enabled

  form do |f|
    tabs do
      tab 'Information' do
        f.inputs 'Information' do
          admin_translation_text_field(product, 'product', 'name_translations')
          f.input :reference_code

          f.input :enabled
          f.input :visible

          admin_translation_text_field(product, 'product', 'short_description_translations', component: ActiveAdminHelper::TEXT_AREA)
          admin_translation_text_field(product, 'product', 'description_translations', component: ActiveAdminHelper::CK_EDITOR)

          f.input :publication_date
          f.input :unpublication_date
        end

        f.inputs t('activerecord.models.feature.other') do
          render partial: 'admin/products/features', locals: {product: product,
                                                              languages: Language.in_backoffice,
                                                              features: Feature.all}
        end

        f.inputs 'Price' do
          f.input :retail_price_pre_tax, input_html: {onchange: 'javascript:change_price_pre_tax(this);'}
          f.input :retail_price, input_html: {onchange: 'javascript:change_price(this);'}

          taxes = Tax.all
          render partial: 'admin/products/taxes', locals: {taxes: taxes, tax: product.tax}
        end

        if commerce && commerce.enable_commerce_options
          f.inputs 'Stock' do
            f.input :stock
            f.input :control_stock
          end
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
          admin_translation_text_field(product, 'product', 'meta_tags_translations')
          admin_translation_text_field(product, 'product', 'slug_translations', hint: 'Chars not allowed: (Upper chars) spaces')
          f.input :show_action_name, hint: 'File name of show render'
        end
      end

      if commerce && commerce.enable_commerce_options
        tab 'Transport' do
          f.inputs 'Transport' do
            f.input :width, hint: 'cm'
            f.input :height, hint: 'cm'
            f.input :depth, hint: 'cm'
            f.input :weight, hint: 'kg'
          end
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
