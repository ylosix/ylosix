module ApplicationHelper
  def initialize_breadcrumb
    add_breadcrumb(Breadcrumb.new(url: root_path, name: 'Home'))
  end

  def add_breadcrumb(breadcrumb)
    unless breadcrumb.nil?
      @variables ||= {}
      @variables['breadcrumbs'] ||= []
      @variables['breadcrumbs'] << breadcrumb.to_liquid
    end
  end

  def append_debug_variables(admin_user, variables, html_content)
    if !admin_user.nil? && admin_user.debug_variables
      content_hash_variables = Utils.pretty_json_template_variables(variables)
      html_code = JSON.pretty_generate(content_hash_variables)
      html_content += "<br /><pre><code>#{html_code}</code></pre>"
    end

    html_content
  end
end
