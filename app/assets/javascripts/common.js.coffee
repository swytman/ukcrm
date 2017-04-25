$(document).ready ->

  $('#tabs a').click (e) ->
    $(this).tab('show')
  # переключаемся на вкладку общие
  $('#tabs a[href="#base"]').tab('show')


  $('.form-horizontal select').chosen({ width: '100%' })

  $('.checkbox-all').click (e) ->
    el = $(this)
    group = el.data('group')
    items = $(".checkbox-item[data-group='#{group}'")
    if el.prop('checked') == true
      items.prop('checked', true)
    else
      items.prop('checked', false)
