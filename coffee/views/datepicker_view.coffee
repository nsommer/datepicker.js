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