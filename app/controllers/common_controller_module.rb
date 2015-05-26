module CommonControllerModule
  def get_template_variables(template)
    @variables = {} if @variables.nil?

    @variables['languages'] = Language.in_frontend
    @variables['categories'] = Category.root_categories
    @variables['products'] = Product.all.limit(10) # TODO This only for test.

    @variables['current_customer'] = current_customer

    unless template.nil?
      @variables['template_public_path'] = template.path.gsub('/public', '')
    end

    @variables['authenticity_token'] = form_authenticity_token
    helper = Rails.application.routes.url_helpers

    # Action form
    @variables['action_search_url'] = helper.searches_path
    # Links a

    @variables['action_search_url'] = helper.searches_path
    if current_customer.nil?
      # Action form
      @variables['action_customer_sign_in_url'] = customer_session_path
      @variables['customer_sign_in_alert'] = flash[:alert] unless flash[:alert].blank?

      # Links a
      @variables['customer_forgot_password_href'] = new_customer_password_path
      @variables['customer_sign_up_href'] = new_customer_registration_path
      @variables['customer_new_session_href'] = helper.new_customer_session_path
    else
      # Action form
      @variables['customer_destroy_session_href'] = destroy_customer_session_path
    end
  end

  def render(*args)
    template = Template.find_by(enabled: true)
    contains_template_layout = false
    unless args.empty?
      contains_template_layout = args.include?(layout: 'template_layout')
    end

    get_template_variables(template)
    file_html = "#{controller_name}_#{action_name}.html"

    if !contains_template_layout && !template.nil? && template.ok?(file_html)
      body_code = template.reads_file(file_html)
      body_code = Utils.replace_regex_include(@variables, template, body_code)

      # Parses and compiles the template
      template_liquid = Liquid::Template.parse(body_code)

      @head_javascript = template.reads_file('common_js.js')
      @head_css = template.reads_file('common_css.css')
      @body_content = template_liquid.render(@variables)

      render layout: 'template_layout'
    else
      super
    end
  end
end