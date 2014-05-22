this.domain = {}

domain.setGrouping = (grouping) ->
  newUrl = "#{window.location.origin}#{window.location.pathname}?group_by=#{grouping}"
  domain.visit newUrl

domain.toggleTechniques = ($button, $list) ->
  if $button.hasClass("icon-arrow-right-after") ||
     $button.hasClass("icon-arrow-down-after")
    $button.toggleClass("icon-arrow-right-after").toggleClass("icon-arrow-down-after")
  $list.toggle()

domain.peekAtAllTechniques = ($list, $toggleLink, $peekLinks) ->
  $toggleLink.click() unless $list.is(":visible")

  allOpen = $peekLinks.toArray().reduce ((acc, link) ->
    acc && $(link).hasClass('peek__link--peeking')
  ), true

  $peekLinks.each ->
    $(this).click() unless !allOpen and $(this).hasClass("peek__link--peeking")

domain.peekAtTechnique = ($link, $description) ->
  unless domain.inlineEditing
    $description.toggle()
    $link.toggleClass("peek__link--peeking").toggleClass("icon-eye-blocked")
    $link.parents("li").find(".inline-edit").toggle()

domain.injectSpinner = ->
  unless $('.spinner').length > 0 or domain.timer
    domain.timer = setTimeout(
      (-> $('<div class="spinner"></div>').appendTo('html').hide().fadeIn('fast')),
      100)

domain.removeSpinner = ->
  clearTimeout(domain.timer)
  domain.timer = undefined
  $('.spinner').fadeOut('fast', -> $(@).remove())

domain.toggleNav = ($nav) ->
  $nav.slideToggle('fast')

domain.log = (message) ->
  console.log message
  $.post "/logs", message: "===================\nclient side log: #{message}\n==================="

domain.newTechniqueFieldset = ($form, $fieldset, lastFieldSet) ->
  $clone = $fieldset.clone()
  $clone.find(":input").val("")

  (inheritSelectValues = ->
    selects =
      fieldset: $fieldset.find("select")
      clone: $clone.find("select")

    $clone.find("select").each (index, element) ->
      valueOfPreviousSelect = selects.fieldset[index].value
      $(selects.clone[index]).val(valueOfPreviousSelect)
  )()

  lastFieldSet().after $clone

domain.removeFieldset = ($fieldset) -> $fieldset.remove()

domain.validateBulkTechniqueForm = (event) ->
  inputs = $(this)
    .find("input:not([type='submit']):not([type='hidden']), textarea, select")
    .toArray()

  for input in inputs
    if input.value.length == 0
      alert "You need to fill out all fields"
      event.preventDefault()
      break

domain.visit = (url) -> Turbolinks.visit url

domain.inlineEditing = false

domain.toggleInlineEdit = ($button, $technique) ->
  if domain.inlineEditing
    domain.stopInlineEdit.apply this, arguments
  else
    domain.startInlineEdit.apply this, arguments

domain.startInlineEdit = ($button, $technique) ->
  domain.inlineEditing = true

  $technique.find(".rest-in-place")
    .show()
    .data("restInPlaceEditor")
    .activate()
  $technique.find(".technique__description").hide()
  $technique.find(".rest-in-place-description").attr("id", "rest-in-place-description")
  $technique.find(".peek__link").attr("disabled", "disabled")

domain.stopInlineEdit = ($button, $technique) ->
  domain.inlineEditing = false

  $technique.find(".peek__link").removeAttr("disabled")
  $technique.find(".rest-in-place").hide()
  $technique.find(".technique__description").show()
