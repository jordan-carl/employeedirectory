'use strict'

app =
  initialize: ->
    self = this
    self.store = new MemoryStore ->
      $('body').html new HomeView(self.store).render().el

    $(".search-key").on "keyup", ($.proxy self.findByName, self)
    self.homeTpl = Handlebars.compile $("#home-tpl").html()
    self.employeeLiTpl = Handlebars.compile $("#employee-li-tpl").html()

  showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)

app.initialize()
