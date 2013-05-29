// Generated by CoffeeScript 1.6.1
'use strict';
var HomeView;

HomeView = (function() {

  HomeView.liTemplate = Handlebars.compile($('#employee-li-tpl').html());

  HomeView.template = Handlebars.compile($('#home-tpl').html());

  function HomeView(store) {
    var _this = this;
    this.findByName = function() {
      return store.findByName($('.search-key').val(), function(employees) {
        return $('.employee-list').html(HomeView.liTemplate(employees));
      });
    };
    this.render = function() {
      _this.el.html(HomeView.template());
      return _this;
    };
    this.el = $('<div class="homePage page stage-center" />');
    this.el.on('keyup', '.search-key', this.findByName);
  }

  return HomeView;

})();
