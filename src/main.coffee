'use strict'

app =
  findByName: ->
    self = this
    @store.findByName $(".search-key").val(), (employees) ->
      $(".employee-list").html self.employeeLiTpl employees

  initialize: ->
    self = this
    self.store = new MemoryStore ->
      self.renderHomeView()

    $(".search-key").on "keyup", ($.proxy self.findByName, self)
    self.homeTpl = Handlebars.compile $("#home-tpl").html()
    self.employeeLiTpl = Handlebars.compile $("#employee-li-tpl").html()

  showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)

app.initialize()
