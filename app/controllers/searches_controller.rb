class SearchesController < Frontend::CommonController
  layout 'searcher_and_side_bar'

  def index
    @variables ||= {}
    @variables['products'] = []
    @variables['products'] += array_to_liquid(Product.search_by_text(@query_text)) unless @query_text.blank?
  end

  def get_template_variables(template)
    super
  end

  protected

  def set_breadcrumbs
  end
end
