// Generated by CoffeeScript 1.6.1
'use strict';
var App;

App = (function() {

  App.detailsURL = /^#employees\/(\d+)/;

  App.showAlert = function(message, title) {
    if (navigator.notification) {
      return navigator.notification.alert(message, null, title, "OK");
    } else {
      return alert(title ? "" + title + ": " + message : message);
    }
  };

  function App(handler) {
    var options,
      _this = this;
    this.page = 0;
    this.route = function() {
      var hash, match;
      hash = window.location.hash;
      if (!hash) {
        if (_this.homePage) {
          _this.slidePage(_this.homePage, true);
        } else {
          _this.homePage = new HomeView(_this.store).render(true);
          _this.currentPage = _this.homePage;
          _this.homePage.el.appendTo('#thelist');
        }
        return;
      }
      match = hash.match(App.detailsURL);
      if (match) {
        return _this.store.findById(Number(match[1]), function(employee) {
          return _this.slidePage(new EmployeeView(employee).render());
        });
      }
    };
    this.registerEvents = function() {
      var $body, event_begin, event_end, tappable, touchable;
      tappable = 'tappable-active';
      touchable = document.documentElement.hasOwnProperty('ontouchstart');
      event_begin = touchable ? 'touchstart' : 'mousedown';
      event_end = touchable ? 'touchend' : 'mouseup';
      $body = $('#thelist');
      $body.on(event_begin, 'a', function(event) {
        return $(event.target).addClass(tappable);
      });
      $body.on(event_end, 'a', function(event) {
        return $(event.target).removeClass(tappable);
      });
      return $(window).on('hashchange', $.proxy(this.route, this));
    };
    this.registerEvents();
    options = {
      snap: true,
      momentum: false,
      hScrollbar: false,
      vScroll: false,
      onScrollEnd: function() {
        if (this.page !== this.currPageX && this.currPageX === 0) {
          window.location.hash = '#';
        }
        return this.page = this.currPageX;
      }
    };
    this.scroller = new iScroll('wrapper', options);
    this.handle = function($el, clear) {
      var ms,
        _this = this;
      if (clear == null) {
        clear = false;
      }
      ms = 300;
      return setTimeout(function() {
        _this.scroller.refresh();
        _this.scroller.scrollToPage((clear ? 0 : 1), 0, ms);
        if (clear) {
          setTimeout(function() {
            _this.scroller.disable();
            return $el.remove();
          }, ms);
        } else {
          _this.scroller.enable();
        }
        return setTimeout(function() {
          return $('.scroll', '.homePage').css({
            width: clear ? '100%' : '50%'
          });
        }, clear ? 0 : ms);
      }, 0);
    };
    this.slidePage = function(page, clear) {
      var $el;
      if (clear == null) {
        clear = false;
      }
      $el = $(page.el);
      if (page !== _this.homePage) {
        _this.handle($el.appendTo('#thelist'));
      }
      if (clear) {
        _this.handle($('.page:not(.homePage)', '#thelist'), true);
      }
      return handler($el, clear);
    };
    this.store = new MemoryStore(function() {
      return _this.route();
    });
  }

  return App;

})();
