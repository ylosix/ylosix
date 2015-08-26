class Breadcrumb
  attr_accessor :url, :name

  include InitializeAttr

  def to_liquid
    {
        'url' => url,
        'name' => name
    }
  end
end
