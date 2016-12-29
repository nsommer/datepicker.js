(function ($) {
  'use strict'
  
  QUnit.module("Datepicker", {
    before: function () {
      this.datepicker = $("#date-input").datepicker()
    },
    beforeEach: function () {
      // December 1, 2016
      this.datepicker.setDate(new Date(2016, 11, 1))
    }
  })

  QUnit.test("Previous day", function (assert) {
    this.datepicker.previousDay()
    var expectedDate = new Date(2016, 10, 30)
    assert.deepEqual(this.datepicker.getDate(), expectedDate)
  })
  
  QUnit.test("Next day", function (assert) {
    this.datepicker.nextDay()
    var expectedDate = new Date(2016, 11, 2)
    assert.deepEqual(this.datepicker.getDate(), expectedDate)
  })
  
  QUnit.test("Previous week", function (assert) {
    this.datepicker.previousWeek()
    var expectedDate = new Date(2016, 10, 24)
    assert.deepEqual(this.datepicker.getDate(), expectedDate)
  })
  
  QUnit.test("Next week", function (assert) {
    this.datepicker.nextWeek()
    var expectedDate = new Date(2016, 11, 8)
    assert.deepEqual(this.datepicker.getDate(), expectedDate)
  })
  
  QUnit.test("Previous month", function (assert) {
    this.datepicker.previousMonth()
    var expectedDate = new Date(2016, 10, 1)
    assert.deepEqual(this.datepicker.getDate(), expectedDate)
  })
  
  QUnit.test("Next month", function (assert) {
    this.datepicker.nextMonth()
    var expectedDate = new Date(2017, 0, 1)
    assert.deepEqual(this.datepicker.getDate(), expectedDate)
  })
})(jQuery)