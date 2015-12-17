module TemplateFunctions
  def parse_liquid(variables, html_code)
    template_liquid = Liquid::Template.parse(html_code)
    template_liquid.render(variables)
  end
end
