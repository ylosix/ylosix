class SearchesController < Frontend::CommonController
  def index
    @variables ||= {}
    @variables['products'] = []
    @variables['products'] += Product.search_by_text(@query_text) unless @query_text.blank?
  end

  def get_template_variables(template)
    super
  end

  protected

  def set_breadcrumbs
  end
end
