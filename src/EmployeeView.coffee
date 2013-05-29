'use strict'

class EmployeeView
  @template: Handlebars.compile $('#employee-tpl').html()

  constructor: (details) ->
    @addLocation = (event) ->
      event.preventDefault()
      navigator.geolocation.getCurrentPosition (position) ->
        coords = position.coords
        $('.location').html "#{coords.latitude}, #{coords.longitude}"
      , -> App.showAlert 'Error getting location!', 'Error'
      false

    @addToContacts = (event) ->
      event.preventDefault()

      if not navigator.contacts
        App.showAlert 'Contacts API not supported', 'Error'
        return

      contact = navigator.contacts.create()
      contact.name = givenName: details.firstName, familyName: details.lastName
      contact.phoneNumbers = [
        new ContactField 'work', details.officePhone, false
        new ContactField 'mobile', details.cellPhone, true
      ]
      contact.save()
      false

    @changePicture = (event) ->
      event.preventDefault()

      if not navigator.camera
        App.showAlert 'Camera API not supported', 'Error'
        return

      options =
        quality: 50
        sourceType: 1
        encodingType: 0
        destinationType: Camera.DestinationType.DATA_URL

      navigator.camera.getPicture (imageData) ->
        $('.employee-image').attr 'src', "data:image/jpeg;base64,#{imageData}"
      , ->
        App.showAlert 'Error taking picture!', 'Error'
      , options
      false

    @render =->
      @el.html EmployeeView.template details
      @

    @el = $('<div class="page"/>')
      .on('click', '.add-contact-btn', @addToContacts)
      .on('click', '.add-location-btn', @addLocation)
      .on 'click', '.change-pic-btn', @changePicture
