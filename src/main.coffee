'use strict'

$ ->
  $body = $('body')
  $document = $(document)
  $wrapper = $('#wrapper')
  navBarHeight = $('.navbar').first().height()
  scrollTop = 0
  minHeight = 40

  closeLid = (e) ->
    $document.scrollTop navBarHeight
    e.preventDefault()

  on_scroll =->
    stop = $document.scrollTop()
    if stop < navBarHeight then $wrapper.click closeLid
    else $wrapper.off()

    $.doTimeout 'scrolling', 150, ->
      $document.scrollTop if (navBarHeight - stop) < stop then navBarHeight else 0
    scrollTop = stop

  $document.on 'scroll', $body, on_scroll
  $document.scrollTop navBarHeight
  app = new App ($el, clear=false) -> null
