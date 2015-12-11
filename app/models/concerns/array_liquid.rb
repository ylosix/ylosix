module ArrayLiquid
  extend ActiveSupport::Concern

  def array_to_liquid(array, options = {})
    return [] unless array

    array_liquid = []
    array.each do |elem|
      if elem.class == Hash
        array_liquid << elem
      else
        array_liquid << elem.to_liquid(options)
      end
    end

    array_liquid
  end
end
