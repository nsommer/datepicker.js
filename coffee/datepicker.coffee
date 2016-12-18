###
  datepicker.js
  Copyright (C) by Nils Sommer, 2016
  
  Released under the MIT license.
###

# Class that represents the state and methods for a datepicker.
class Datepicker
  # Initialize a new Datepicker for a specific input field.
  #
  # Parameters
  #
  #   input - The dom element this datepicker will be attached to
  #   date  - Date object of the currently selected day (default: today)
  constructor: (@input, @date = new Date) ->
    @view = new DatepickerView(@date)
    @registerEvents()
    
  rerenderView: ->
    @input.parent().find('.datepicker').remove()
    @view.setActiveDate @date
    @input.parent().append @view.render()
  
  registerEvents: ->
    root = @input.parent()
    
    # Previous month button
    $(root).on 'click', '[data-action="prev"]', =>
      @previousMonth()
      @rerenderView()
    
    # Next month button
    $(root).on 'click', '[data-action="next"]', =>
      @nextMonth()
      @rerenderView()
    
  # Show the datepicker.
  show: ->
    @input.parent().append @view.render()
    # TODO: Generate day buttuns, register keyboard events
    
  nextDay: ->
    @date.setDate @date.getDate() + 1
    
  previousDay: ->
    @date.setDate @date.getDate() - 1
    
  nextWeek: ->
    @date.setDate @date.getDate() + 7
    
  previousWeek: ->
    @date.setDate @date.getDate() - 7
    
  nextMonth: ->
    month = @date.getMonth()
    
    if month < 11
      @date.setMonth month + 1
    else
      @date.setMonth 0
      @date.setFullYear @date.getFullYear() + 1
    
  previousMonth: ->
    month = @date.getMonth()
    
    if month is 0
      @date.setMonth 11
      @date.setFullYear @date.getFullYear() - 1
    else
      @date.setMonth month - 1
    
    
  # Hide the datepicker.
  hide: ->
    @input.parent().find('.datepicker').remove()
    
# Zero config data api implementation
#
# Registers a click event handler that instantiates a Datepicker
# object on the first click and connects it to the input element in the dom
# that invoked the event.
$(document).on 'click.datepicker.data-api', '[data-toggle="datepicker"]', (event) ->
  event.preventDefault()
  $this = $(this)
  $this.each -> 
    $this = $(this)
    data = $this.data 'datepicker'
    unless data
      $this.data 'datepicker', (data = new Datepicker($this))
      data.show()
  