this.domain = {}

domain.setGrouping = ->
  grouping = $(this).val()
  newUrl = "#{window.location.origin}#{window.location.pathname}?group_by=#{grouping}"
  redirectTo(newUrl)

domain.toggleTechniques = (event) ->
  event.preventDefault()
  $(this).parent().next('ul').slideToggle('fast')

# private

redirectTo = (url) -> window.location.href = url
