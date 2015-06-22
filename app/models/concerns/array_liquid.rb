module ArrayLiquid
  extend ActiveSupport::Concern

  def array_to_liquid(array)
    array_liquid = []
    array.each do |elem|
      array_liquid << elem.to_liquid
    end

    array_liquid
  end
end
