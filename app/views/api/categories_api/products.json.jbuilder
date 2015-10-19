json.array!(@products) do |product|
  product.to_liquid.each do |k,v|
    json.set! k, v
  end
end
