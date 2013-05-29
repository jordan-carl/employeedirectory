// Generated by CoffeeScript 1.6.1
'use strict';
var HomeView;

HomeView = (function() {

  HomeView.liTemplate = Handlebars.compile($('#employee-li-tpl').html());

  HomeView.template = Handlebars.compile($('#home-tpl').html());

  function HomeView(store) {
    var _this = this;
    this.findByName = function() {
      return store.findByName($('.search-key').val(), function(results) {
        return $('.employee-list').html(HomeView.liTemplate(results));
      });
    };
    this.render = function() {
      _this.el.html(HomeView.template());
      return _this;
    };
    this.el = $('<div class="homePage page stage-center" />').on('keyup', '.search-key', this.findByName);
    setTimeout(function() {
      return $('.search-key', this.el).focus();
    });
  }

  return HomeView;

})();
