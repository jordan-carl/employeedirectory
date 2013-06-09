'use strict'

class HomeView
  @liTemplate: Handlebars.compile $('#employee-li-tpl').html()
  @template: Handlebars.compile $('#home-tpl').html()

  constructor: (store) ->
    @findByName =->
      store.findByName $('.search-key').val(), (results) =>
        $el = $('.employee-list', '.homePage').html HomeView.liTemplate results

        if @iscroll then @iscroll.refresh()
        else @iscroll = new iScroll $el[0], hScrollbar: false, vScrollbar: false, hScroll: false

    @render = =>
      @el.html HomeView.template()
      @

    @el = $('<li class="page homePage" />').on 'keyup', '.search-key', @findByName

    #setTimeout =>
    #  $('.search-key', @el).focus()
    #  @findByName()
    #, 100

    $.doTimeout 100, =>
      $('.search-key', @el).focus()
      @findByName()
