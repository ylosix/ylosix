class HomeController < Frontend::CommonController
  layout 'searcher_and_side_bar'

  def index
  end

  def get_template_variables(template)
    super
  end

  protected

  def set_breadcrumbs
  end
end
