var app = {

    findByName: function() {
        console.log('findByName');
        this.store.findByName($('.search-key').val(), function(employees) {
            var l = employees.length;
            var e;
            $('.employee-list').empty();
            for (var i=0; i<l; i++) {
                e = employees[i];
                $('.employee-list').append('<li><a href="#employees/' + e.id + '">' + e.firstName + ' ' + e.lastName + '</a></li>');
            }
        });
    },

    initialize: function() {
        var self = this;
        self.store = new MemoryStore(function () {
          self.showAlert('Store initialized', 'Info');
        });
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
