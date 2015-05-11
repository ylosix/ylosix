class Utils
  def self.get_parents_array(object)
    array = []

    parent = object.parent
    until parent.nil?
      array << parent
      parent = parent.parent
    end

    array.reverse
  end
end