'use strict'

class App
  @detailsURL: /^#employees\/(\d+)/

  @showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else alert if title then "#{title}: #{message}" else message

  constructor: (handler) ->
    @page = 0

    @route = =>
      hash = window.location.hash

      if not hash
        if @homePage then @slidePage @homePage, true
        else
          @homePage = new HomeView(@store).render true
          @currentPage = @homePage
          @homePage.el.appendTo '#thelist'
        return

      match = hash.match App.detailsURL
      if match
        @store.findById (Number match[1]), (employee) =>
          @slidePage new EmployeeView(employee).render()

    @registerEvents =->
      tappable = 'tappable-active'
      touchable = document.documentElement.hasOwnProperty 'ontouchstart'
      event_begin = if touchable then 'touchstart' else 'mousedown'
      event_end = if touchable then 'touchend' else 'mouseup'

      $body = $('#thelist')
      $body.on event_begin, 'a', (event) -> $(event.target).addClass tappable
      $body.on event_end, 'a', (event) -> $(event.target).removeClass tappable
      $(window).on 'hashchange', ($.proxy @route, @)

    @registerEvents()

    options =
      snap: true
      momentum: false
      hScrollbar: false
      vScroll: false
      onScrollEnd: ->
        window.location.hash = '#' if @page isnt @currPageX and @currPageX is 0
        @page = @currPageX

    @scroller = new iScroll 'wrapper', options

    @handle = ($el, clear=false) ->
      ms = 300
      setTimeout =>
        @scroller.refresh()
        @scroller.scrollToPage (if clear then 0 else 1), 0, ms

        if clear then setTimeout =>
          @scroller.disable()
          $el.remove()
        , ms else @scroller.enable()

        setTimeout ->
          $('.scroll', '.homePage').css width: if clear then '100%' else '50%'
        , if clear then 0 else ms
      , 0

    @slidePage = (page, clear=false) =>
      $el = $(page.el)
      @handle $el.appendTo '#thelist' if page isnt @homePage
      @handle $('.page:not(.homePage)', '#thelist'), true if clear
      handler $el, clear

    @store = new MemoryStore => @route()
