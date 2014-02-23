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

domain.peekAtTechnique = ($link, $listItem) ->
  if $link.hasClass("peek__link--peeking")
    $link.removeClass("peek__link--peeking").removeClass("icon-eye-blocked")
    domain.removeTechniqueDescription($listItem)
  else
    $.ajax
      url: "/techniques/#{$link.data('technique-id')}"
      dataType: "json"
    .done (data) =>
      $link.addClass("peek__link--peeking").addClass("icon-eye-blocked")
      domain.injectTechniqueDescription(data.technique.description, $listItem)

domain.injectTechniqueDescription = (description, $listItem) ->
  node = $('<p class="peek__description">').html(description)
  $listItem.append(node)

domain.removeTechniqueDescription = ($listItem) ->
  $listItem.find(".peek__description").remove()

domain.closeFlash = ($flash) ->
  $flash.remove()

domain.toggleNewNoteForm = ($button, $form) ->
  $form.toggle()
  if $form.is(":visible")
    $button.text("-")
  else
    $button.text("+")

domain.toggleNav = ($nav) ->
  $nav.slideToggle('fast')

# private

redirectTo = (url) -> window.location.href = url
