module Api
  class CategoriesApiController < CategoriesController
    def products
      @products = []
      @products = Product.in_frontend(@category) if @category
    end
  end
end
