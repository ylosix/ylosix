module Frontend
  module CommonModule
    def append_language_variables
      @variables['languages'] = Language.in_frontend
      @variables['locale'] = I18n.default_locale.to_s
      @variables['locale'] = session[:locale] unless session[:locale].blank?
    end

    def append_customer_variables(helper)
      @variables['current_customer'] = current_customer
      @variables['customer_carts_href'] = customers_shopping_carts_path

      if customer_signed_in?
        # Action form
        @variables['customer_destroy_session_href'] = destroy_customer_session_path
        @variables['customer_edit_registration_href'] = edit_customer_registration_path
        @variables['customer_orders_href'] = orders_customers_path
      else
        # Action form
        @variables['action_customer_sign_in_url'] = customer_session_path
        @variables['action_customer_sign_up_url'] = customer_registration_path

        # Links a
        @variables['customer_forgot_password_href'] = new_customer_password_path
        @variables['customer_sign_up_href'] = new_customer_registration_path
        @variables['customer_new_session_href'] = helper.new_customer_session_path
      end

      sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
      @variables['shopping_cart'] = sc
    end

    def append_message_variables
      @variables['error_messages'] = []
      if defined? resource
        @variables['error_messages'] = resource.errors.full_messages unless resource.nil?
        @variables['resource'] = resource
      end

      @variables['error_messages_title'] = Utils.get_error_title(@variables['error_messages'])

      flash.each do |key, value|
        @variables["#{key}_message"] = value
      end
    end

    def append_link_variables(helper)
      @variables['authenticity_token'] = form_authenticity_token
      @variables['action_search_url'] = helper.searches_path
    end

    def get_template_variables(template)
      @variables ||= {}

      append_message_variables
      append_language_variables

      @variables['categories'] = Category.root_categories
      @variables['products'] ||= Product.all.limit(10) # TODO This only for test.

      unless template.nil?
        @variables['template_public_path'] = template.path.gsub('/public', '')
      end

      helper = Rails.application.routes.url_helpers
      append_link_variables(helper)
      append_customer_variables(helper)
    end

    def render_template(template, file_html, args)
      body_code = template.reads_file(file_html)
      body_code = Utils.replace_regex_include(@variables, template, body_code)
      body_code = Utils.append_debug_variables(current_admin_user, @variables, body_code)

      # Parses and compiles the template
      template_liquid = Liquid::Template.parse(body_code)

      @head_javascript = template.reads_file('common_js.js')
      @head_css = template.reads_file('common_css.css')
      @body_content = template_liquid.render(@variables)

      hash = {}
      hash = args[0] if args.any?
      hash[:layout] = 'template_layout'
      render hash
    end

    def retrieve_file_html(controller, action, args = [])
      file_html = "#{controller}/#{action}.html"

      # Fixed route devise when fails sign up.
      if controller == 'registrations' && args.include?(action: :new)
        file_html = "#{controller}/new.html"
      end

      file_html
    end

    def render(*args)
      get_template_variables(@render_template)

      file_html = retrieve_file_html(controller_name, action_name, args)
      contains_template_layout = (args.any? && args[0][:layout] == 'template_layout')
      if !contains_template_layout && !@render_template.nil? && @render_template.ok?(file_html)
        render_template(@render_template, file_html, args)
      else
        super
      end
    end
  end
end
