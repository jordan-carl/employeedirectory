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

  app = new App ($el, clear=false) -> null

  on_scroll =->
    stop = $document.scrollTop()
    if stop < navBarHeight
      $wrapper.click closeLid
      app.scroller.disable()
    else
      $wrapper.off()
      app.scroller.enable()

    $.doTimeout 'scrolling', 150, ->
      $document.scrollTop if (navBarHeight - stop) < stop then navBarHeight else 0
    scrollTop = stop

  $document.on 'scroll', $body, on_scroll
  $document.scrollTop navBarHeight
