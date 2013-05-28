'use strict'

HomeView = (store) ->
  @findByName =->
    store.findByName $('.search-key').val(), (employees) ->
      $('.employee-list').html HomeView.liTemplate employees

  @liTemplate = Handlebars.compile $('#employee-li-tpl').html()
  @render =->
    @el.html HomeView.template()
    @
  @template = Handlebars.compile $('#home-tpl').html()

  @initialize =-> $('<div/>').on 'keyup', '.search-key', @findByName
  @initialize()

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
