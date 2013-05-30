// Generated by CoffeeScript 1.6.1
'use strict';
var HomeView;

HomeView = (function() {

  HomeView.liTemplate = Handlebars.compile($('#employee-li-tpl').html());

  HomeView.template = Handlebars.compile($('#home-tpl').html());

  function HomeView(store) {
    var _this = this;
    this.findByName = function() {
      var _this = this;
      return store.findByName($('.search-key').val(), function(results) {
        var $el;
        $el = $('.employee-list', '.homePage').html(HomeView.liTemplate(results));
        if (_this.iscroll) {
          return _this.iscroll.refresh();
        } else {
          return _this.iscroll = new iScroll($el[0], {
            hScrollbar: false,
            vScrollbar: false,
            hScroll: false
          });
        }
      });
    };
    this.render = function() {
      _this.el.html(HomeView.template());
      return _this;
    };
    this.el = $('<li class="page homePage" />').on('keyup', '.search-key', this.findByName);
    setTimeout(function() {
      $('.search-key', _this.el).focus();
      return _this.findByName();
    }, 100);
  }

  return HomeView;

})();
