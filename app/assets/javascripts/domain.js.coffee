this.domain = {}

domain.setGrouping = (grouping) ->
  newUrl = "#{window.location.origin}#{window.location.pathname}?group_by=#{grouping}"
  redirectTo newUrl

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
  $description.toggle()
  $link.toggleClass("peek__link--peeking").toggleClass("icon-eye-blocked")

domain.closeFlash = ($flash) ->
  $flash.remove()

domain.toggleNewNoteForm = ($button, $form) ->
  $form.toggle()
  if $form.is(":visible")
    $form.find("textarea").first().focus()
    $button.text("-")
  else
    $button.text("+")

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

# private

redirectTo = (url) -> window.location.href = url
