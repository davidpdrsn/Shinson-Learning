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
  domain.timer = setTimeout(
    (-> $('<div class="spinner"></div>').appendTo('html').hide().fadeIn('fast')),
    100)

domain.removeSpinner = ->
  clearTimeout(domain.timer)
  $('.spinner').fadeOut('fast', -> $(@).remove())

domain.toggleNav = ($nav) ->
  $nav.slideToggle('fast')

domain.log = (message) ->
  console.log message
  $.post "/logs", message: "===================\nclient side log: #{message}\n==================="

# private

redirectTo = (url) -> window.location.href = url
