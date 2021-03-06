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

class ProductsController < Frontend::CommonController
  before_action :set_product

  def show
  end

  def append_variables
    super

    if @category
      @variables['meta_tags'] = @category.meta_tags_hash
      add_show_action_name(@category)

      array_categories = Utils.get_parents_array(@category)
      array_categories.delete_at(0) if array_categories.any? # delete root.
      array_categories << @category unless @category.nil? # append current category.
      array_categories << @product unless @product.nil? # append current product.

      array_categories.each do |category|
        add_breadcrumb(Breadcrumb.new(url: category.href, name: category.name))
      end
    end

    if @product
      @variables['meta_tags'] = @product.meta_tags_hash
      @liquid_options[:features] = true
      @liquid_options[:tags] = true
      @variables['product'] = @product.to_liquid(@liquid_options)

      add_show_action_name(@product)
    end
  end

  def add_to_shopping_cart
    sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
    sc.add_product(@product)

    if customer_signed_in?
      sc.customer = current_customer
      sc.save
    else
      session[:shopping_cart] = sc.to_json(include: :shopping_carts_products)
    end

    link = :show_shopping_carts
    if !@variables['my_site'].nil? && @variables['my_site']['no_redirect_shopping_cart']
      link = request.referer || request.url || root_url
    end

    redirect_to link
  end

  def delete_from_shopping_cart
    if customer_signed_in?
      sc = current_customer.shopping_cart

      unless sc.blank?
        sc.remove_product(@product)
        current_customer.shopping_cart = sc
        current_customer.save

        # TODO save Shopping Cart in cache
      end
    end

    redirect_to :show_shopping_carts
  end

  protected

  def set_breadcrumbs
  end

  def set_product
    # TODO find product by category id
    # if params[:category_slug].blank?
    #   @category = Category.find_by(slug: params[:category_slug])
    # end

    t = Link.arel_table
    link = Link.where(t[:slug].eq(params[:product_id])
                          .or(t[:object_id].eq(params[:product_id]))).take

    fail ActiveRecord::RecordNotEnabled if link && !link.enabled

    @product = Product.find(link.object_id) if link

    if @product
      @category = @product.categories.first if @product.categories.any?
    else
      fail ActiveRecord::RecordNotFound
    end
  end
end
