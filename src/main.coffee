'use strict'

$ ->
  $body = $('body')
  $document = $(document)
  $wrapper = $('#wrapper')
  navBarHeight = $('.navbar').first().height()
  scrollTop = 0

  on_scroll =->
    stop = $document.scrollTop()
    if stop < navBarHeight then $wrapper.click (e) =>
      $document.scrollTop navBarHeight
      e.preventDefault()
    else $wrapper.off()

    if scrollTop > stop and stop isnt 0 then snap = 0
    else  if scrollTop < stop and stop isnt navBarHeight then snap = navBarHeight

    $.doTimeout 'scrolling', 150, -> $document.scrollTop snap
    scrollTop = stop

  $document.scrollTop navBarHeight
  $document.on 'scroll', $body, on_scroll
  app = new App ($el, clear=false) -> null
