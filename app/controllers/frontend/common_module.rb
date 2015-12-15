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

      @liquid_options = {current_tags: set_tags}
      @variables['categories'] = array_to_liquid(Category.root_categories, @liquid_options) # TODO This only for test.
      @variables['products'] ||= array_to_liquid(Product.all.limit(10)) # TODO This only for test.

      append_general_tags(@liquid_options)

      append_link_variables
      append_customer_variables
    end

    def fill_descriptions_with_variables(hash, template)
      if hash.class == Hash
        hash.each do |k, v|
          if v.class.name == 'Array'
            v.each do |elem|
              fill_descriptions_with_variables(elem, template)
            end
          end

          fill_descriptions_with_variables(v, template) if v.class.name == 'Hash'

          if k.to_s.include?('description') && !v.blank?
            v = Utils.replace_regex_include(@variables, template, v)

            # Parses and compiles the description field
            template_liquid = Liquid::Template.parse(v)
            hash[k] = template_liquid.render(@variables)
          end
        end
      end
    end

    def parse_template(body_code)
      template_liquid = Liquid::Template.parse(body_code)
      template_liquid.render(@variables)
    end

    def render_template(template, file_html)
      body_code = template.reads_file(file_html)
      body_code = Utils.replace_regex_include(@variables, template, body_code)

      # Parses and compiles the template
      @head_javascript = parse_template(template.reads_file('common_js.js'))
      @head_css = parse_template(template.reads_file('common_css.css'))

      @body_content = render_to_string(inline: parse_template(body_code))
      @body_content = append_debug_variables(current_admin_user, @variables, @body_content)
    end

    def retrieve_file_html(controller, action, args = [])
      file_html = "#{controller}/#{action}.html"

      if %w(show tags).include?(action) && !@variables['show_action_name'].blank?
        if !@render_template.nil? &&
            @render_template.ok?("#{controller}/#{@variables['show_action_name']}.html")
          file_html = "#{controller}/#{@variables['show_action_name']}.html"
        end
      end

      # Fixed route devise when fails sign up.
      if controller == 'registrations' && action == 'create'
        file_html = "#{controller}/new.html"
      end

      # Fixed route devise when fails edit.
      if controller == 'registrations' && action == 'update'
        file_html = "#{controller}/edit.html"
      end

      # Fixed route pretty urls
      if controller == 'dynamic_path' && action == 'show_path'
        prefix = 'categories'
        prefix = 'products' if @product.present?

        if !@render_template.nil? &&
            @render_template.ok?("#{prefix}/#{@variables['show_action_name']}.html")
          file_html = "#{prefix}/#{@variables['show_action_name']}.html"
        else
          file_html = "#{prefix}/show.html"
        end
      end

      # Fixed errors like 404
      if args.is_a?(Array) && args.any? && args[0].is_a?(String) && args[0].start_with?('errors/')
        file_html = "#{args[0]}.html"
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
      fill_descriptions_with_variables(@variables, @render_template)

      file_html = retrieve_file_html(controller_name, action_name, args)
      has_custom_layout = args.is_a?(Array) && args.any? && args[0].is_a?(Hash) && args[0][:layout] == 'custom_template'

      if !@render_template.nil? && @render_template.ok?(file_html) && !has_custom_layout
        render_template(@render_template, file_html)
        render text: '', layout: 'custom_template'
      else
        super
      end
    end
  end
end
