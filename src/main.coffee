'use strict'

$ ->
  myScroll = new iScroll 'wrapper',
    snap: true
    momentum: false
    hScrollbar: false
    vScroll: false
    vScrollbar: false
    onScrollEnd: ->
      $('#indicator > li.active').attr 'class', ''
      $("#indicator > li:nth-child(#{ @currPageX + 1 })").addClass 'active'

  onResize = ($el, clear=false) ->
    time = 300
    setTimeout ->
      myScroll.refresh()
      myScroll.scrollToPage (if clear then 0 else 1), 0, time
      if clear then setTimeout ->
        myScroll.disable()
        $el.remove()
      , time else myScroll.enable()
    , 0

  app = new App(onResize)
