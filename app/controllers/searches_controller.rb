class SearchesController < CommonFrontendController
  def index
    @products = []

    unless @query_text.blank?
      @products = Product.search_by_text(@query_text)
    end
  end

  def get_template_variables(template)
    super
  end
end
