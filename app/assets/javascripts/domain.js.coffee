this.domain = {}

domain.setGrouping = ->
  grouping = $(this).val()
  newUrl = "#{window.location.origin}#{window.location.pathname}?group_by=#{grouping}"
  redirectTo(newUrl)

domain.toggleTechniques = (event) ->
  event.preventDefault()
  $(this)
    .toggleClass("icon-arrow-right-after")
    .toggleClass("icon-arrow-down-after")
    .parent()
    .next('ul')
    .toggle()

domain.peekAtTechnique = (event) ->
  event.preventDefault()

  if $(this).hasClass("peek__link--peeking")
    $(this).removeClass("peek__link--peeking").removeClass("icon-eye-blocked")
    domain.removeTechniqueDescription(this)
  else
    $.ajax
      url: "/techniques/#{$(this).data('technique-id')}"
      dataType: "json"
    .done (data) =>
      $(this).addClass("peek__link--peeking").addClass("icon-eye-blocked")
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

domain.closeFlash = (event) ->
  event.preventDefault()
  $(this).parents(".flash").remove()

domain.toggleNewNoteForm = (event) ->
  event.preventDefault()
  $newNote = $(".new_note")
  $button = $(event.target)
  $('.new_note').toggle()
  if $newNote.is(":visible")
    $button.text("-")
  else
    $button.text("+")

domain.toggleNav = (event) ->
  event.preventDefault()
  $('.main-header__nav').slideToggle('fast')

# private

redirectTo = (url) -> window.location.href = url
