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
        if @homePage then @slidePage @homePage
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

    @slidePage = (page) =>
      $('.page:not(.homePage)').remove()

      el = page.el
      homepage = (page is @homePage)
      $(el).attr 'class', "page stage-#{if homepage then 'left' else 'right' }"
      direction = (if homepage then 'right' else 'left')
      $('body').append el

      setTimeout =>
        $(@currentPage.el).attr 'class', "page transition stage-#{direction}#{if homepage then '' else ' homePage'}"
        $(el).attr 'class', "page stage-center transition#{if homepage then ' homePage' else ''}"
        @currentPage = page

    @store = new MemoryStore => @route()
