class SearchesController < CommonFrontendController
  def index
    @products = []
    @products += Product.search_by_text(@query_text) unless @query_text.blank?
  end

  def get_template_variables(template)
    super
  end
end
