'use strict'

class App
  @detailsURL: /^#employees\/(\d+)/

  @showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)

  constructor: ->
    @route = =>
      hash = window.location.hash

      if not hash
        if @homePage then @slidePage @homePage, true
        else
          @homePage = new HomeView(@store).render true
          @currentPage = @homePage
          $('body').append @homePage.el
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

      $body = $('body')
      $body.on event_begin, 'a', (event) -> $(event.target).addClass tappable
      $body.on event_end, 'a', (event) -> $(event.target).removeClass tappable
      $(window).on 'hashchange', ($.proxy @route, @)

    @registerEvents()

    @slidePage = (page, clear=false) =>
      $el = $(page.el)
      if page isnt @homePage
        $el.css left: '100%'
        $el.appendTo 'body'
        $el.swipe
          threshold: 0
          swipe: (event, direction, distance, duration, fingers) =>
            document.location.hash = '#' if direction is 'right'

      options =
        duration: 300
        complete: =>
          $('.page:not(.homePage)').remove() if clear
          @currentPage = page

      setTimeout ->
        $('html,body').scrollTo $el, $el, animation:options
      , 300

    @store = new MemoryStore => @route()
