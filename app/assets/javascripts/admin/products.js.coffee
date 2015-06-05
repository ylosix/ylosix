@taxes_inputs = () ->
  select_taxes = $('#product_tax_id')
  selected_index_tax = select_taxes.prop("selectedIndex")

  taxes_inputs = $('#taxes input')
  [taxes_inputs, selected_index_tax]

rate_tax = (taxes_inputs, selected_index_tax) ->
  rate = parseFloat($(taxes_inputs[selected_index_tax - 1]).val()) / 100.0
  rate

@change_price_pre_tax = (input) ->
  params = @taxes_inputs()
  taxes_inputs = params[0]
  selected_index_tax = params[1]

  price_pre_tax = parseFloat($(input).val())
  price = price_pre_tax
  if ( selected_index_tax > 0 && selected_index_tax <= taxes_inputs.length )
    rate = rate_tax(taxes_inputs, selected_index_tax)
    price = (price_pre_tax * (1.0 + rate)).toFixed(2)

  $('#product_retail_price').val(price)

@change_price = (input) ->
  params = @taxes_inputs()
  taxes_inputs = params[0]
  selected_index_tax = params[1]

  price = parseFloat($(input).val())
  price_pre_tax = price
  if ( selected_index_tax > 0 && selected_index_tax <= taxes_inputs.length )
    rate = rate_tax(taxes_inputs, selected_index_tax)
    price_pre_tax = (price / (1.0 + rate)).toFixed(5)

  $('#product_retail_price_pre_tax').val(price_pre_tax)

@change_tax = (select) ->
  params = @taxes_inputs()
  taxes_inputs = params[0]
  selected_index_tax = params[1]

  price_pre_tax = parseFloat($('#product_retail_price_pre_tax').val())
  price = price_pre_tax
  if ( selected_index_tax > 0 && selected_index_tax <= taxes_inputs.length )
    rate = rate_tax(taxes_inputs, selected_index_tax)
    price = (price_pre_tax * (1.0 + rate)).toFixed(2)

  $('#product_retail_price').val(price)
