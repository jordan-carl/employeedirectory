'use strict'

class HomeView
  @liTemplate: Handlebars.compile $('#employee-li-tpl').html()
  @template: Handlebars.compile $('#home-tpl').html()

  constructor: (store) ->
    @findByName =->
      store.findByName $('.search-key').val(), (employees) ->
        $('.employee-list').html HomeView.liTemplate employees

    @render = =>
      @el.html HomeView.template()
      @

    @el = $('<div class="homePage page stage-center" />')
    @el.on 'keyup', '.search-key', @findByName
