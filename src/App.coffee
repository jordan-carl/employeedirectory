'use strict'

class App
  @detailsURL: /^#employees\/(\d+)/

  @showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)

  constructor: (onResize) ->
    @route = =>
      hash = window.location.hash

      if not hash
        if @homePage then @slidePage @homePage, true
        else
          @homePage = new HomeView(@store).render true
          @currentPage = @homePage
          $('#thelist').append @homePage.el
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

    @slidePage = (page, clear=false) =>
      onResize $(page.el).appendTo '#thelist' if page isnt @homePage
      onResize $('.page:not(.homePage)', '#thelist'), true if clear

    @store = new MemoryStore => @route()
