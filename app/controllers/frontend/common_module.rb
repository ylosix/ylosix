module Frontend
  module CommonModule
    include ArrayLiquid
    include ApplicationHelper

    def set_tags
      tags = []
      unless params[:slug_tags].blank?
        params[:slug_tags].split('/').each do |id|
          tag = Tag.find_by(id: id)
          tags << tag unless tag.nil?
        end
      end

      ids = tags.map(&:id)
      slugs = tags.map(&:slug)

      [tags, ids, slugs]
    end

    def append_general_tags(liquid_options)
      @variables['tags_group'] ||= array_to_liquid(TagsGroup.retrieve_groups)

      tags = []
      tags = liquid_options[0] if liquid_options
      @variables['selected_tags'] = array_to_liquid(tags)
    end

    def append_language_variables
      @variables['languages'] = Language.in_frontend
      @variables['locale'] = I18n.default_locale.to_s
      @variables['locale'] = session[:locale] unless session[:locale].blank?
    end

    def append_customer_variables
      @variables['current_customer'] = current_customer
      @variables['show_shopping_carts_path'] = Routes.show_shopping_carts_path
      @variables['clear_shopping_carts_path'] = Routes.clear_shopping_carts_path
      @variables['shipping_method_customers_shopping_orders_path'] = Routes.shipping_method_customers_shopping_orders_path

      if customer_signed_in?
        # Action form

        @variables['customer_edit_registration_href'] = Routes.edit_customer_registration_path # DEPRECATED
        @variables['customer_orders_href'] = Routes.orders_customers_path # DEPRECATED
        @variables['customers_addresses_path'] = Routes.customers_addresses_path
      else
        # Action form
        @variables['action_customer_sign_in_url'] = Routes.customer_session_path
        @variables['action_customer_sign_up_url'] = Routes.customer_registration_path

        # Links a
        @variables['customer_forgot_password_href'] = Routes.new_customer_password_path
        @variables['customer_sign_up_href'] = Routes.new_customer_registration_path
        @variables['customer_new_session_href'] = Routes.new_customer_session_path
      end

      sc = ShoppingCart.retrieve(current_customer, session[:shopping_cart])
      @variables['shopping_cart'] = sc.to_liquid
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

    def append_link_variables
      @variables['authenticity_token'] = form_authenticity_token
      @variables['action_search_url'] = Routes.searches_path
    end

    def append_variables
      @variables ||= {}

      append_message_variables
      append_language_variables

      @liquid_options = {features: true, current_tags: set_tags}
      @liquid_options[:current_category] = @category if @category
      @liquid_options[:current_product] = @product if @product
      @liquid_options[:current_commerce] = @commerce if @commerce

      @variables['categories'] = array_to_liquid(Category.root_categories(@commerce.tree_category), @liquid_options)

      append_general_tags(@liquid_options)

      append_link_variables
      append_customer_variables
    end

    def render_template(template, file_html)
      body_code = template.reads_file(file_html)
      body_code = Utils.replace_regex_include(@variables, template, body_code)

      # First time filling descriptions
      template_first = Liquid::Template.parse(body_code)
      body_code = template_first.render(@variables)
      @body_content = Utils.replace_regex_include(@variables, template, body_code)

      @head_javascript = template.reads_file('common_js.js')
      @head_css = template.reads_file('common_css.css')

      html_code = render_to_string(text: '', layout: 'custom_template')

      # Second time with descriptions
      template_second = Liquid::Template.parse(html_code)
      template_second.instance_assigns = template_first.instance_assigns
      html_code = template_second.render(@variables)
      html_code = Utils.replace_regex_include(@variables, template, html_code)

      # Third time with descriptions
      template_third = Liquid::Template.parse(html_code)
      template_third.instance_assigns = template_second.instance_assigns
      html_code = template_third.render(@variables)
      html_code = Utils.replace_regex_include(@variables, template, html_code)

      append_debug_variables(current_admin_user, @variables, html_code)
    end

    def retrieve_file_html(controller, action, args = [])
      # Fixed errors like 404
      if args.is_a?(Array) && args.any? && args[0].is_a?(String) && args[0].start_with?('errors/')
        return "#{args[0]}.html"
      end

      file_html = "#{controller}/#{action}.html"
      if %w(show tags).include?(action) && !@variables['show_action_name'].blank?
        if !@render_template.nil? &&
            @render_template.ok?("#{controller}/#{@variables['show_action_name']}.html")
          file_html = "#{controller}/#{@variables['show_action_name']}.html"
        end
      end

      if controller == 'registrations'
        case action
          when 'create' # Fixed route devise when fails sign up.
            file_html = "#{controller}/new.html"
          when 'update' # Fixed route devise when fails edit.
            file_html = "#{controller}/edit.html"
        end
      end

      # Fixed route pretty urls
      if controller == 'dynamic_path' && action == 'show_path'
        prefix = 'categories'
        prefix = 'products' if @product.present?

        if !@render_template || !@render_template.ok?("#{prefix}/#{@variables['show_action_name']}.html")
          return "#{prefix}/show.html"
        end

        file_html = "#{prefix}/#{@variables['show_action_name']}.html"
      end

      file_html
    end

    def determine_layout
      file_html = retrieve_file_html(controller_name, action_name)
      if !@render_template.nil? && @render_template.ok?(file_html)
        'custom_template'
      else
        case self.class.name
          when 'CategoriesController', 'HomeController', 'ProductsController', 'SearchesController'
            'searcher_and_side_bar'
          when 'ShoppingCartsController', 'ShoppingOrdersController'
            'shopping'
          else
            'application'
        end
      end
    end

    def render(*args)
      append_variables

      file_html = retrieve_file_html(controller_name, action_name, args)
      has_custom_layout = args.is_a?(Array) && args.any? && args[0].is_a?(Hash) && args[0][:common_module]

      if !@render_template.nil? && @render_template.ok?(file_html) && !has_custom_layout
        render text: render_template(@render_template, file_html), common_module: true
      else
        super
      end
    end
  end
end
