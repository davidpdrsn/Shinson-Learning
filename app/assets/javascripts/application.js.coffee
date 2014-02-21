//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$ ->
  $(document).on "change", 'select[name="groupings"]', ->
    grouping = $(this).val()
    newUrl = window.location.origin + window.location.pathname + "?group_by=" + grouping
    window.location.href = newUrl

  $(document).on 'click', '.toggle-techniques', (e) ->
    e.preventDefault()
    $(this).parent().next('ul').slideToggle('fast')
