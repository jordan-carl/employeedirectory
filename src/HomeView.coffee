'use strict'

class HomeView
  constructor: (store) ->
    @findByName =->
      store.findByName $('.search-key').val(), (employees) ->
        $('.employee-list').html HomeView.liTemplate employees

    @render =-> @el.html HomeView.template()
    $('<div/>').on 'keyup', '.search-key', @findByName

  liTemplate: Handlebars.compile $('#employee-li-tpl').html()
  template: Handlebars.compile $('#home-tpl').html()
