'use strict'

class App
  @detailsURL: /^#employees\/(\d+)/

  @showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)

  constructor: ->
    @store = new MemoryStore =>
      $('body').html new HomeView(@store).render()

    @route = ->
      hash = window.location.hash

      if not hash
        $('body').html new HomeView(@store).render()
        return

      match = hash.match App.detailsURL
      return if not match

      @store.findById (Number match[1]), (employee) ->
        $('body').html new EmployeeView(employee).render()

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
