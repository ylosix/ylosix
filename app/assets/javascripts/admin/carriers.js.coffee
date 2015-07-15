@index = 999

@add_table_prices_columns = () ->
  trs = $('#table_prices tr')

  for tr, i in trs[0...trs.length]
    if i < 2
      if i == 0
        $(tr).append("<th><input type='number' name='carriers_ranges[][" + @index + "][greater_equal_than]' value='0.0' /></th>")
      else
        $(tr).append("<th><input type='number' name='carriers_ranges[][" + @index + "][lower_than]' value='0.0' /></th>")
    else
      if i == trs.length - 1
        $(tr).append("<td><a onclick='javascript: return remove_table_prices_column(this);' href='#'>Remove</a></td>")
      else
        input = $(tr).find('input')[0]
        input = $(input)

        checkbox = $(tr).find('[type="checkbox"]')[0]
        tag_disabled = ""
        if !$(checkbox).is(':checked')
          tag_disabled = "disabled='disabled'"

        $(tr).append("<td>" +
            "<input type='number' name='carriers_ranges[][" + @index + "][zones][][amount]' value='0.0' " + tag_disabled + " />" +
            "<input type='number' name='carriers_ranges[][" + @index + "][zones][][zone_id]' value='"+ input.val() + "' " + tag_disabled + " class='hide' />" +
            "</td>")

  @index++
  return false

@click_checkbox_table_prices = (row, checkbox) ->
  tr = $('#table_prices tr')[row]
  inputs = $(tr).find('[type="number"]')

  for input in inputs
    if $(checkbox).is(':checked')
      $(input).removeAttr('disabled')
    else
      $(input).attr('disabled', 'disabled')

  return false

@remove_table_prices_column = (a) ->
  col_index = $(a).parent().index()
  $('#table_prices tr').find('td:eq(' + col_index + '), th:eq(' + col_index + ')').remove();

  return false