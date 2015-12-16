json.array!(@products) do |product|
  product_fields = product.to_liquid(@liquid_options)
  product_fields.each do |k,v|
    json.set! k, v
  end
end
