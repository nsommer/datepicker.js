
/*
  datepicker.js
  Copyright (C) by Nils Sommer, 2016
  https://github.com/nsommer/datepicker.js
  Released under the MIT license.
 */

(function() {
  var Datepicker, DatepickerView;

  DatepickerView = (function() {
    DatepickerView.prototype.buildDaysMarkup = function() {
      var buffer, buttonClasses, day, i, liClasses, month_begin, month_end, offsetWidth, ref, ref1;
      buffer = "";
      month_begin = new Date(this.activeDate);
      month_begin.setDate(1);
      month_end = new Date(this.activeDate);
      month_end.setMonth(this.activeDate.getMonth() + 1);
      month_end.setDate(0);
      for (day = i = ref = month_begin.getDate(), ref1 = month_end.getDate(); ref <= ref1 ? i <= ref1 : i >= ref1; day = ref <= ref1 ? ++i : --i) {
        buttonClasses = this.activeDate.getDate() === day ? " active" : "";
        offsetWidth = month_begin.getDay() === 0 ? 6 : month_begin.getDay() - 1;
        liClasses = day === 1 ? "day-col-coffset-" + offsetWidth : "";
        buffer += "<li class=\"" + liClasses + "\"> <button type=\"button\" class=\"day-button" + buttonClasses + "\"> <time datetime=\"" + (this.activeDate.getFullYear()) + "-" + (this.activeDate.getMonth() + 1) + "-" + day + "\"> " + day + " </time> </button> </li>";
      }
      return buffer;
    };

    DatepickerView.prototype.getMonthName = function(date) {
      switch (date.getMonth()) {
        case 0:
          return "January";
        case 1:
          return "Feburary";
        case 2:
          return "March";
        case 3:
          return "April";
        case 4:
          return "May";
        case 5:
          return "June";
        case 6:
          return "July";
        case 7:
          return "August";
        case 8:
          return "September";
        case 9:
          return "October";
        case 10:
          return "November";
        case 11:
          return "December";
      }
    };

    DatepickerView.prototype.view = function() {
      return "<div class=\"datepicker datepicker-" + this.position + "\">\n  <div class=\"datepicker-header\">\n    <button type=\"button\" class=\"datepicker-control datepicker-control-left\" data-action=\"prev\">\n      <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"8\" height=\"8\" viewBox=\"0 0 8 8\">\n        <path d=\"M4 0l-4 4 4 4v-8z\" transform=\"translate(2)\" />\n      </svg>\n    </button>\n    <span class=\"datepicker-month\">" + (this.getMonthName(this.activeDate)) + ", " + (this.activeDate.getFullYear()) + "</span>\n    <button type=\"button\" class=\"datepicker-control datepicker-control-right\" data-action=\"next\">\n      <svg xmlns=\"http://www.w3.org/2000/svg\" width=\"8\" height=\"8\" viewBox=\"0 0 8 8\">\n        <path d=\"M0 0v8l4-4-4-4z\" transform=\"translate(2)\" />\n      </svg>\n    </button>\n  </div>\n  <ul class=\"datepicker-days-header\">\n    <li>Mon</li>\n    <li>Tue</li>\n    <li>Wed</li>\n    <li>Thu</li>\n    <li>Fri</li>\n    <li>Sat</li>\n    <li>Sun</li>\n  </ul>\n  <ul class=\"datepicker-days\">\n    " + (this.buildDaysMarkup()) + "\n  </ul>\n</div>";
    };

    function DatepickerView(activeDate, position1) {
      this.activeDate = activeDate;
      this.position = position1 != null ? position1 : "top";
    }

    DatepickerView.prototype.getPosition = function() {
      return this.position;
    };

    DatepickerView.prototype.setActiveDate = function(activeDate) {
      this.activeDate = activeDate;
    };

    DatepickerView.prototype.render = function() {
      return this.view();
    };

    return DatepickerView;

  })();

  Datepicker = (function() {
    Datepicker.EVENT_NS = ".datepicker";

    Datepicker.KEYS = {
      LEFT: 37,
      RIGHT: 39,
      UP: 38,
      DOWN: 40,
      ENTER: 13,
      TAB: 9,
      ESCAPE: 27
    };

    Datepicker.SELECTORS = {
      WIDGET: ".datepicker",
      INPUT: '[data-toggle="datepicker"]',
      BTN_PREV: '[data-action="prev"]',
      BTN_NEXT: '[data-action="next"]',
      BTN_DAY: ".day-button"
    };

    Datepicker.DATA_ATTR = "datepicker";

    function Datepicker(input, date1) {
      var position;
      this.input = input;
      this.date = date1 != null ? date1 : new Date;
      position = this.input.data("position");
      if (position != null) {
        this.view = new DatepickerView(this.date, position);
      } else {
        this.view = new DatepickerView(this.date);
      }
      this.registerEvents();
    }

    Datepicker.prototype.rerenderView = function() {
      this.input.parent().find(Datepicker.SELECTORS.WIDGET).remove();
      this.view.setActiveDate(this.date);
      return this.input.parent().append(this.view.render());
    };

    Datepicker.prototype.registerEvents = function() {
      var datepicker, root;
      root = this.input.parent();
      $(root).on("click" + Datepicker.EVENT_NS, Datepicker.SELECTORS.BTN_PREV, (function(_this) {
        return function() {
          _this.previousMonth();
          return _this.rerenderView();
        };
      })(this));
      $(root).on("click" + Datepicker.EVENT_NS, Datepicker.SELECTORS.BTN_NEXT, (function(_this) {
        return function() {
          _this.nextMonth();
          return _this.rerenderView();
        };
      })(this));
      datepicker = this;
      $(root).on("click" + Datepicker.EVENT_NS, Datepicker.SELECTORS.BTN_DAY, function() {
        datepicker.selectDate(this);
        datepicker.updateInputVal();
        return datepicker.hide();
      });
      return this.input.on("keydown" + Datepicker.EVENT_NS, function(event) {
        switch (event.which) {
          case Datepicker.KEYS.LEFT:
            datepicker.previousDay();
            return datepicker.rerenderView();
          case Datepicker.KEYS.RIGHT:
            datepicker.nextDay();
            return datepicker.rerenderView();
          case Datepicker.KEYS.UP:
            datepicker.previousWeek();
            return datepicker.rerenderView();
          case Datepicker.KEYS.DOWN:
            datepicker.nextWeek();
            return datepicker.rerenderView();
          case Datepicker.KEYS.ENTER:
            datepicker.updateInputVal();
            datepicker.hide();
            return false;
          case Datepicker.KEYS.TAB:
            return datepicker.hide();
          case Datepicker.KEYS.ESCAPE:
            return datepicker.hide();
        }
      });
    };

    Datepicker.prototype.show = function() {
      return this.input.parent().append(this.view.render());
    };

    Datepicker.prototype.selectDate = function(dayButton) {
      return this.date.setDate($(dayButton).text());
    };

    Datepicker.prototype.updateInputVal = function() {
      return this.input.val(this.getDateAsString());
    };

    Datepicker.prototype.hide = function() {
      return this.input.parent().find(Datepicker.SELECTORS.WIDGET).remove();
    };

    Datepicker.prototype.getDate = function() {
      return this.date;
    };

    Datepicker.prototype.setDate = function(date1) {
      this.date = date1;
    };

    Datepicker.prototype.getDateAsString = function() {
      return (this.date.getFullYear()) + "-" + (this.date.getMonth() + 1) + "-" + (this.date.getDate());
    };

    Datepicker.prototype.nextDay = function() {
      return this.date.setDate(this.date.getDate() + 1);
    };

    Datepicker.prototype.previousDay = function() {
      return this.date.setDate(this.date.getDate() - 1);
    };

    Datepicker.prototype.nextWeek = function() {
      return this.date.setDate(this.date.getDate() + 7);
    };

    Datepicker.prototype.previousWeek = function() {
      return this.date.setDate(this.date.getDate() - 7);
    };

    Datepicker.prototype.nextMonth = function() {
      var month;
      month = this.date.getMonth();
      if (month < 11) {
        return this.date.setMonth(month + 1);
      } else {
        this.date.setMonth(0);
        return this.date.setFullYear(this.date.getFullYear() + 1);
      }
    };

    Datepicker.prototype.previousMonth = function() {
      var month;
      month = this.date.getMonth();
      if (month === 0) {
        this.date.setMonth(11);
        return this.date.setFullYear(this.date.getFullYear() - 1);
      } else {
        return this.date.setMonth(month - 1);
      }
    };

    return Datepicker;

  })();

  $.fn.datepicker = function() {
    var datepicker;
    datepicker = this.data(Datepicker.DATA_ATTR);
    if (datepicker == null) {
      this.data(Datepicker.DATA_ATTR, (datepicker = new Datepicker(this)));
    }
    return datepicker;
  };

  $(document).on("focusin" + Datepicker.EVENT_NS + ".data-api", Datepicker.SELECTORS.INPUT, function(event) {
    var $this;
    event.preventDefault();
    $this = $(this);
    return $this.each(function() {
      var data;
      $this = $(this);
      data = $this.data(Datepicker.DATA_ATTR);
      if (!data) {
        $this.data(Datepicker.DATA_ATTR, (data = new Datepicker($this)));
      }
      return data.show();
    });
  });

  $(document).on("click" + Datepicker.EVENT_NS + ".dismiss", function(event) {
    var $target;
    $target = $(event.target);
    if (!($target.closest(Datepicker.SELECTORS.WIDGET).length || $target.closest(Datepicker.SELECTORS.INPUT).length)) {
      return $(Datepicker.SELECTORS.INPUT).each(function() {
        var datepicker;
        if ((datepicker = $(this).data(Datepicker.DATA_ATTR))) {
          return datepicker.hide();
        }
      });
    }
  });

}).call(this);

//# sourceMappingURL=datepicker.js.map
