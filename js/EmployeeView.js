// Generated by CoffeeScript 1.6.1
'use strict';
var EmployeeView;

EmployeeView = (function() {

  EmployeeView.template = Handlebars.compile($('#employee-tpl').html());

  function EmployeeView(details) {
    this.addLocation = function(event) {
      event.preventDefault();
      navigator.geolocation.getCurrentPosition(function(position) {
        var coords;
        coords = position.coords;
        return $('.location').html("" + coords.latitude + ", " + coords.longitude);
      }, function() {
        return App.showAlert('Error getting location!', 'Error');
      });
      return false;
    };
    this.addToContacts = function(event) {
      var contact;
      event.preventDefault();
      if (!navigator.contacts) {
        App.showAlert('Contacts API not supported', 'Error');
        return;
      }
      contact = navigator.contacts.create();
      contact.name = {
        givenName: details.firstName,
        familyName: details.lastName
      };
      contact.phoneNumbers = [new ContactField('work', details.officePhone, false), new ContactField('mobile', details.cellPhone, true)];
      contact.save();
      return false;
    };
    this.changePicture = function(event) {
      var options;
      event.preventDefault();
      if (!navigator.camera) {
        App.showAlert('Camera API not supported', 'Error');
        return;
      }
      options = {
        quality: 50,
        sourceType: 1,
        encodingType: 0,
        destinationType: Camera.DestinationType.DATA_URL
      };
      navigator.camera.getPicture(function(imageData) {
        return $('.employee-image').attr('src', "data:image/jpeg;base64," + imageData);
      }, function() {
        return App.showAlert('Error taking picture!', 'Error');
      }, options);
      return false;
    };
    this.render = function() {
      var $el;
      $el = $('<div/>').html(EmployeeView.template(details));
      $el.on('click', '.add-contact-btn', this.addToContacts);
      $el.on('click', '.add-location-btn', this.addLocation);
      return $el.on('click', '.change-pic-btn', this.changePicture);
    };
  }

  return EmployeeView;

})();
