###
  datepicker.js
  Copyright (C) by Nils Sommer, 2016
  https://github.com/nsommer/datepicker.js
  Released under the MIT license.
###
# View of the Datepicker widget.
#
# Usage:
#
#   widget = new DatepickerView(new Date)
#   widget.render
#
#   #=> Returns the HTML markup of the widget
class DatepickerView
  # Creates the day buttons markup.
  buildDaysMarkup: ->
    buffer = ""
    month_begin = new Date(@activeDate)
    month_begin.setDate(1)
    month_end = new Date(@activeDate)
    month_end.setMonth(@activeDate.getMonth() + 1)
    month_end.setDate(0)
        
    for day in [month_begin.getDate()..month_end.getDate()]
      buttonClasses = if @activeDate.getDate() is day then " active" else ""
      offsetWidth = if month_begin.getDay() is 0 then 6 else month_begin.getDay() - 1
      liClasses = if day is 1 then "day-col-coffset-#{offsetWidth}" else ""
      buffer += "<li class=\"#{liClasses}\">
                   <button type=\"button\" class=\"day-button#{buttonClasses}\">
                     <time datetime=\"#{@activeDate.getFullYear()}-#{@activeDate.getMonth() + 1}-#{day}\">
                       #{day}
                     </time>
                   </button>
                 </li>"
      
    buffer
    
  # Get the name of a month by numbers from 0-11
  # (pass Date#getMonth()).
  getMonthName: (date) ->
    switch date.getMonth()
      when 0  then "January"
      when 1  then "Feburary"
      when 2  then "March"
      when 3  then "April"
      when 4  then "May"
      when 5  then "June"
      when 6  then "July"
      when 7  then "August"
      when 8  then "September"
      when 9  then "October"
      when 10 then "November"
      when 11 then "December"
  
  # The actual view template.
  #
  # The template contains variables/sub methods to fill it
  # with dynamic content via string interpolation.
  #
  # Implemented as a method to reevaluate the string template
  # every render call.
  view: ->
    """
    <div class="datepicker datepicker-#{@position}">
      <div class="datepicker-header">
        <button type="button" class="datepicker-control datepicker-control-left" data-action="prev">
          <svg xmlns="http://www.w3.org/2000/svg" width="8" height="8" viewBox="0 0 8 8">
            <path d="M4 0l-4 4 4 4v-8z" transform="translate(2)" />
          </svg>
        </button>
        <span class="datepicker-month">#{@getMonthName @activeDate}, #{@activeDate.getFullYear()}</span>
        <button type="button" class="datepicker-control datepicker-control-right" data-action="next">
          <svg xmlns="http://www.w3.org/2000/svg" width="8" height="8" viewBox="0 0 8 8">
            <path d="M0 0v8l4-4-4-4z" transform="translate(2)" />
          </svg>
        </button>
      </div>
      <ul class="datepicker-days-header">
        <li>Mon</li>
        <li>Tue</li>
        <li>Wed</li>
        <li>Thu</li>
        <li>Fri</li>
        <li>Sat</li>
        <li>Sun</li>
      </ul>
      <ul class="datepicker-days">
        #{@buildDaysMarkup()}
      </ul>
    </div>
    """
  
  # Initialize the view.
  constructor: (@activeDate, @position = "top") ->
  
  # Get the position of the widget (top or bottom).
  getPosition: ->
    @position
  
  # Set the selected date.
  setActiveDate: (@activeDate) ->
  
  # Render the whole view. 
  render: ->
    @view()
# Class that represents the state and methods for a datepicker.
class Datepicker
  @EVENT_NS: ".datepicker"
  
  @KEYS:
    LEFT:   37
    RIGHT:  39
    UP:     38
    DOWN:   40
    ENTER:  13
    TAB:    9
    ESCAPE: 27
    
  @SELECTORS:
    WIDGET:   ".datepicker"
    INPUT:    '[data-toggle="datepicker"]'
    BTN_PREV: '[data-action="prev"]'
    BTN_NEXT: '[data-action="next"]'
    BTN_DAY:  ".day-button"
    
  @DATA_ATTR: "datepicker"
  
  # Initialize a new Datepicker for a specific input field.
  #
  # Parameters
  #
  #   input - The dom element this datepicker will be attached to
  #   date  - Date object of the currently selected day (default: today)
  constructor: (@input, @date = new Date) ->
    position = @input.data "position"
    if position?
      @view = new DatepickerView(@date, position)
    else
      @view = new DatepickerView(@date)
    
    @registerEvents()
  
  # Rerender the widget.  
  rerenderView: ->
    @input.parent().find(Datepicker.SELECTORS.WIDGET).remove()
    @view.setActiveDate @date
    @input.parent().append @view.render()
  
  # Register click, focus and keyboard events to control the datepicker.
  # Please notice that the click event handler for the data API are declared
  # outside of this class.
  registerEvents: ->
    root = @input.parent()
    
    # Previous month button
    $(root).on "click#{Datepicker.EVENT_NS}", Datepicker.SELECTORS.BTN_PREV, =>
      @previousMonth()
      @rerenderView()
    
    # Next month button
    $(root).on "click#{Datepicker.EVENT_NS}", Datepicker.SELECTORS.BTN_NEXT, =>
      @nextMonth()
      @rerenderView()
    
    # Day selection button
    # Reference this (datepicker instance) into local variable
    # because we need it in the callback method which itself needs
    # a reference to the clicked button as well.
    datepicker = this
    $(root).on "click#{Datepicker.EVENT_NS}", Datepicker.SELECTORS.BTN_DAY, ->
      datepicker.selectDate(this)
      datepicker.updateInputVal()
      datepicker.hide()
      
    @input.on "keydown#{Datepicker.EVENT_NS}", (event) ->    
      switch event.which
        when Datepicker.KEYS.LEFT   then datepicker.previousDay();    datepicker.rerenderView()
        when Datepicker.KEYS.RIGHT  then datepicker.nextDay();        datepicker.rerenderView()
        when Datepicker.KEYS.UP     then datepicker.previousWeek();   datepicker.rerenderView()
        when Datepicker.KEYS.DOWN   then datepicker.nextWeek();       datepicker.rerenderView()
        when Datepicker.KEYS.ENTER  then datepicker.updateInputVal(); datepicker.hide(); return false; # Don't submit the form!
        when Datepicker.KEYS.TAB    then datepicker.hide() # Hide when tabing out
        when Datepicker.KEYS.ESCAPE then datepicker.hide() # Hide when pressing escape
    
  # Show the datepicker widget.
  show: ->
    @input.parent().append @view.render()
  
  # Set the date based on a pressed day button.
  selectDate: (dayButton) ->
    @date.setDate $(dayButton).text()
  
  # Write the currently selected date back to the attached input field.  
  updateInputVal: ->
    @input.val @getDateAsString()
  
  # Hide the datepicker.
  hide: ->
    @input.parent().find(Datepicker.SELECTORS.WIDGET).remove()
  
  # Get the selected date as a JavaScript date object.
  getDate: ->
    @date
  
  # Set the selected date.
  setDate: (@date) ->
  
  # Get the selected date as an ISO8601 string.
  #
  # Example
  #
  #   datepicker.getDateAsString()
  #     #=> 2016-12-31
  getDateAsString: ->
    "#{@date.getFullYear()}-#{@date.getMonth() + 1}-#{@date.getDate()}"
    
  
  # Methods for jumping from the selected date back and forth
    
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

# jQuery Plugin
#
# Fetches the Datepicker instance for a given input field if it exists.
# Otherwise, it initializes a new Datepicker instance and attaches it
# to the input field.
#
# Example:
#
#   $(selector).datepicker()
$.fn.datepicker = ->
  datepicker = this.data Datepicker.DATA_ATTR
  
  unless datepicker?
    this.data Datepicker.DATA_ATTR, (datepicker = new Datepicker(this))
    
  return datepicker
   
    
# Zero config data api implementation
#
# Registers a click event handler that instantiates a Datepicker
# object on the first click and connects it to the input element in the dom
# that invoked the event.
$(document).on "focusin#{Datepicker.EVENT_NS}.data-api", Datepicker.SELECTORS.INPUT, (event) ->
  event.preventDefault()
  $this = $(this)
  $this.each -> 
    $this = $(this)
    data = $this.data Datepicker.DATA_ATTR
    unless data
      $this.data Datepicker.DATA_ATTR, (data = new Datepicker($this))
    data.show()
  
# Global click handler to register dismiss clicks (= clicks outside the
# widget).
# See https://css-tricks.com/dangers-stopping-event-propagation/
$(document).on "click#{Datepicker.EVENT_NS}.dismiss", (event) ->
  $target = $(event.target)
  unless $target.closest(Datepicker.SELECTORS.WIDGET).length or $target.closest(Datepicker.SELECTORS.INPUT).length
    $(Datepicker.SELECTORS.INPUT).each ->
      if (datepicker = $(this).data Datepicker.DATA_ATTR)
        datepicker.hide()
    