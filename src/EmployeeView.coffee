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

    @render =->
      $el = $('<div/>').html EmployeeView.template details
      $el.on 'click', '.add-location-btn', @addLocation
