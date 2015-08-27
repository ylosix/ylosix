module ShowActionName
  def add_show_action_name(object)
    @variables ||= {}
    @variables['show_action_name'] = object.show_action_name
  end
end
