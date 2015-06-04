class CategoriesController < Frontend::CommonController
  before_action :set_category, except: [:index]

  def index
    @categories = Category.in_frontend
  end

  def show
    @products = []
    @products = Product.in_frontend(@category) unless @category.nil?
  end

  def get_template_variables(template)
    super
  end

  private

  def set_category
    @category = nil

    if !params[:slug].blank? || !params[:id].blank?
      attributes = { enabled: true }
      attributes[:slug] = params[:slug] unless params[:slug].blank?
      attributes[:id] = params[:id] unless params[:id].blank?

      @category = Category.find_by(attributes)
    end
  end
end
