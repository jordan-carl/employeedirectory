'use strict'

class EmployeeView
  @template: Handlebars.compile $('#employee-tpl').html()
  constructor: (details) ->
    @addLocation = (event) ->
      event.preventDefault()
      navigator.geolocation.getCurrentPosition (position) ->
        coords = position.coords
        $('.location').html "#{coords.latitude}, #{coords.longitude}"
      , -> App.showAlert 'Error getting location!'
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

    @render =->
      $el = $('<div/>').html EmployeeView.template details
      $el.on 'click', '.add-location-btn', @addLocation
      $el.on 'click', '.add-contact-btn', @addToContacts
