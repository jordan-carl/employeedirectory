'use strict'

class HomeView
  @liTemplate: Handlebars.compile $('#employee-li-tpl').html()
  @template: Handlebars.compile $('#home-tpl').html()
  constructor: (store) ->
    @findByName =->
      store.findByName $('.search-key').val(), (employees) ->
        $('.employee-list').html HomeView.liTemplate employees

    @render =->
      @el = $ '<div/>'
      @el.html HomeView.template()
      @

    $('<div/>').on 'keyup', '.search-key', @findByName
