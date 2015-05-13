class ProductsController < CommonFrontendController
  before_filter :get_product

  def show
  end

  private

  def get_product
    @product = nil
    @category = nil

    if !params[:slug].blank? or !params[:id].blank?
      attributes = {enabled: true}
      attributes[:slug] = params[:slug] unless params[:slug].blank?
      attributes[:id] = params[:id] unless params[:id].blank?

      @product = Product.find_by(attributes)

      @category = @product.categories.first
    end
  end
end
