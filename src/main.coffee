'use strict'
app =
  findByName: ->
    @store.findByName $(".search-key").val(), (employees) ->
      $(".employee-list").html @employeeLiTpl employees

  initialize: ->
    @store = new MemoryStore ->
      @renderHomeView()

    $(".search-key").on "keyup", ($.proxy @findByName, @)
    @homeTpl = Handlebars.compile $("#home-tpl").html()
    @employeeLiTpl = Handlebars.compile $("#employee-li-tpl").html()

  renderHomeView: ->
    $("body").html @homeTpl()
    $(".search-key").on "keyup", ($.proxy @findByName, @)

  showAlert: (message, title) ->
    if navigator.notification
      navigator.notification.alert message, null, title, "OK"
    else
      alert (if title then "#{title}: #{message}" else message)

app.initialize()
