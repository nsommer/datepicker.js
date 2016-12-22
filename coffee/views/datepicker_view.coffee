# View of the Datepicker widget.
#
# Usage:
#
#   widget = new DatepickerView(new Date)
#   widget.render
#
#   #=> Returns the HTML markup of the widget
class DatepickerView
  build_days_markup: ->
    buffer = ""
    month_begin = new Date(@active_date)
    month_begin.setDate(1)
    month_end = new Date(@active_date)
    month_end.setMonth(@active_date.getMonth() + 1)
    month_end.setDate(0)
        
    for day in [month_begin.getDate()..month_end.getDate()]
      buttonClasses = if @active_date.getDate() is day then " active" else ""
      liClasses = if day is 1 then "day-col-coffset-#{month_begin.getDay() - 1}" else ""
      buffer += "<li class=\"#{liClasses}\"><button type=\"button\" class=\"day-button#{buttonClasses}\">#{day}</button></li>"
      
    buffer
    
    
    
  get_month_name: (date) ->
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
    <div class="datepicker">
      <div class="datepicker-header">
        <button type="button" class="datepicker-control datepicker-control-left" data-action="prev">
          <svg xmlns="http://www.w3.org/2000/svg" width="8" height="8" viewBox="0 0 8 8">
            <path d="M4 0l-4 4 4 4v-8z" transform="translate(2)" />
          </svg>
        </button>
        <span class="datepicker-month">#{@get_month_name @active_date}, #{@active_date.getFullYear()}</span>
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
        #{@build_days_markup()}
      </ul>
    </div>
    """
  
  constructor: (@active_date) ->
    
  setActiveDate: (@active_date) ->
    
  render: ->
    @view()