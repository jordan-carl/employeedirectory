var app = {

    findByName: function() {
      var self = this;
      this.store.findByName($('.search-key').val(), function(employees) {
        $('.employee-list').html(self.employeeLiTpl(employees));
      });
    },

    initialize: function() {
      var self = this;
      self.store = new MemoryStore(function () {
        self.renderHomeView();
      });
      $('.search-key').on('keyup', $.proxy(self.findByName, self));
      self.homeTpl = Handlebars.compile($('#home-tpl').html());
      self.employeeLiTpl = Handlebars.compile($('#employee-li-tpl').html());
    },

    renderHomeView: function () {
      var self = this;
      $('body').html(self.homeTpl());
      $('.search-key').on('keyup', $.proxy(self.findByName, self));
    },

    showAlert: function (message, title) {
      if (navigator.notification) {
        navigator.notification.alert(message, null, title, 'OK');
      } else {
        alert(title? (title + ': ' + message) : message);
      }
    }

};

app.initialize();
