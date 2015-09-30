class SearchesController < Frontend::CommonController
  def index
    @variables ||= {}
    @variables['products'] = []
    @variables['products'] += array_to_liquid(Product.search_by_text(@query_text)) unless @query_text.blank?
  end

  def append_variables
    super
  end

  protected

  def set_breadcrumbs
  end
end
