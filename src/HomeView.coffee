HomeView = (store) ->
  @findByName =->
    store.findByName $('.search-key').val(), (employees) ->
      $('.employee-list').html HomeView.liTemplate employees

  @liTemplate = Handlebars.compile $('#employee-li-tpl').html()
  @render =-> @el.html HomeView.template()
  @template = Handlebars.compile $('#home-tpl').html()

  @initialize =-> $('<div/>').on 'keyup', '.search-key', @findByName
  @initialize()
