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

    @route = =>
      hash = window.location.hash

      if not hash
        @homePage = new HomeView(@store).render() if not @homePage
        @slidePage @homePage
        return

      match = hash.match App.detailsURL
      return if not match

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

    @slidePage = (page) ->
      if not @currentPage
        $(page).attr 'class', 'page stage-center'
        $('body').append page
        @currentPage = page
        return

      $('.stage-right, .stage-left').not('.homePage').remove()

      homepage = (page is @homePage)
      $(page).attr 'class', "page stage-#{if homepage then 'left' else 'right' }"
      direction = (if homepage then 'right' else 'left')

      $('body').empty() if not homepage
      $('body').append page

      setTimeout =>
        $(@currentPage).attr 'class', "page transition stage-#{direction}"
        $(page).attr 'class', 'page stage-center transition'
        @currentPage = page
      , 250
