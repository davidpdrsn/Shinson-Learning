this.domain = {}

domain.setGrouping = ->
  grouping = $(this).val()
  newUrl = "#{window.location.origin}#{window.location.pathname}?group_by=#{grouping}"
  redirectTo(newUrl)

domain.toggleTechniques = (event) ->
  event.preventDefault()
  $(this).parent().next('ul').slideToggle('fast')

domain.peekAtTechnique = (event) ->
  event.preventDefault()

  if $(this).hasClass("peek__link--peeking")
    $(this).text("Peek").removeClass("peek__link--peeking")
    domain.removeTechniqueDescription(this)
  else
    $.ajax
      url: "/techniques/#{$(this).data('technique-id')}"
      dataType: "json"
    .done (data) =>
      $(this).text("Unpeek").addClass("peek__link--peeking")
      domain.injectTechniqueDescription(data.technique.description, this)

domain.injectTechniqueDescription = (description, linkNode) ->
  node = $('<p class="peek__description">').html(description)
  $(linkNode)
    .parent("li")
    .append(node)

domain.removeTechniqueDescription = (linkNode) ->
  $(linkNode)
    .parent("li")
    .find(".peek__description")
    .remove()

# private

redirectTo = (url) -> window.location.href = url
