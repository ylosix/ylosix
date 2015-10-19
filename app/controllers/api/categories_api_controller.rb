module Api
  class CategoriesApiController < CategoriesController
    def products
      @products = []
      @products = Product.in_frontend(@category) unless @category.nil?
    end
  end
end
