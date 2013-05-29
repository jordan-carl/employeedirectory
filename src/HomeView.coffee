'use strict'

class HomeView
  @liTemplate: Handlebars.compile $('#employee-li-tpl').html()
  @template: Handlebars.compile $('#home-tpl').html()

  constructor: (store) ->
    @findByName =->
      store.findByName $('.search-key').val(), (results) ->
        $('.employee-list').html HomeView.liTemplate results

    @render = =>
      @el.html HomeView.template()
      @

    @el = $('<div class="homePage page stage-center" />')
      .on 'keyup', '.search-key', @findByName
