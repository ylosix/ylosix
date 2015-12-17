class ProductsController < Frontend::CommonController
  before_action :set_product

  def show
  end

  def append_variables
    super

    if @category
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
    if !@variables['commerce'].nil? && @variables['commerce']['no_redirect_shopping_cart']
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
