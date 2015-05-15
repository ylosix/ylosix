class CommonFrontendController < ApplicationController
  before_action :set_query_text, :get_root_categories, :get_default_products

  def super_get_template_variables
    variables = {
      'categories' => @categories
    }
    variables.merge!(get_template_variables)
  end

  private

  def set_query_text
    @query_text = ''
    @query_text = params[:query_text] unless params[:query_text].blank?
  end

  def get_root_categories
    root_category = Category.find_by(parent_id: [nil, 0], enabled: true)

    @categories = []
    unless root_category.nil?
      @categories = root_category.children.where(enabled: true,
                                                 appears_in_web: true)
    end
  end

  def get_default_products
    @products = Product.all.limit(10)
  end

  def render(*args)
    template = Template.find_by(enabled: true)

    contains_template_layout = false
    unless args.empty?
      contains_template_layout = args.include?(layout: 'template_layout')
    end

    if !contains_template_layout && !template.nil? && template.ok?("#{controller_name}_#{action_name}.html")
      @head_javascript = template.reads_file('common.js')
      @head_css = template.reads_file('common.js')

      body_code = template.reads_file("#{controller_name}_#{action_name}.html")

      # Parses and compiles the template
      @template = Liquid::Template.parse(body_code)

      variables = super_get_template_variables
      @body_content = @template.render(variables)

      render layout: 'template_layout'
    else
      super
    end
  end
end
