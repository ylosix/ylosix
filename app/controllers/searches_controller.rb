class SearchesController < CommonFrontendController
  def index
    @products = []
    
    unless @query_text.blank?
      #@products = Product.where("products.name LIKE concat('%', ?, '%')", params[:query])
      #@products += Product.where("products.description LIKE concat('%', ?, '%')", params[:query])                    
      @products = Product.search_by_text(@query_text)
    end
  end
end
