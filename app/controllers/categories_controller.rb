class CategoriesController < CommonFrontendController
  before_action :set_category, except: [:index]

  def index
    @categories = Category.where(:enabled => true,
                                 :appears_in_web => true)
  end

  def show
    @products = []

    unless @category.nil?
      @products = Product.includes(:products_categories).
          where(:products_categories => {:category_id => @category.id})
    end
  end

  private

  def set_category
    @category = nil

    if !params[:slug].blank? or !params[:id].blank?
      attributes = {enabled: true}
      attributes[:slug] = params[:slug] unless params[:slug].blank?
      attributes[:id] = params[:id] unless params[:id].blank?

      @category = Category.find_by(attributes)
    end
  end
end
