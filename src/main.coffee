'use strict'

app =
  initialize: ->
    @store = new MemoryStore =>
      $('body').html new HomeView(@store).render().el

    $(".search-key").on "keyup", ($.proxy self.findByName, self)
    @homeTpl = Handlebars.compile $("#home-tpl").html()
    @employeeLiTpl = Handlebars.compile $("#employee-li-tpl").html()
    @

  showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)

app.initialize()
