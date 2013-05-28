'use strict'

class App
  constructor: ->
    @store = new MemoryStore =>
      $('body').html new HomeView(@store).render().el

    $(".search-key").on "keyup", ($.proxy self.findByName, self)

  showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)
