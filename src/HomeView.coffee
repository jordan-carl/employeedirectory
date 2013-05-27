HomeView = (store) ->
  @initialize =->
    $('<div/>').on 'keyup', '.search-key', @findByName

  @liTemplate = Handlebars.compile $('#employee-li-tpl').html()

  @render =-> @el.html HomeView.template()

  @template = Handlebars.compile $('#home-tpl').html()

HomeView.initialize()
