'use strict'

class EmployeeView
  @template: Handlebars.compile $('#employee-tpl').html()
  constructor: (details) ->
    @render =-> $('<div/>').html EmployeeView.template details
