module InitializeAttr
  def initialize(params = {})
    params.each { |key, value| send "#{key}=", value }
  end
end
