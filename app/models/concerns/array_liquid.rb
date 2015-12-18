module ArrayLiquid
  extend ActiveSupport::Concern

  def array_to_liquid(array, options = {})
    return [] unless array

    array_liquid = array.map do |elem|
      if elem.class == Hash
        elem
      else
        elem.to_liquid(options)
      end
    end

    array_liquid
  end
end
