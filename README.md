# datepicker.js [![Build Status](https://travis-ci.com/nsommer/datepicker.js.svg?token=9wV4WzAqZguZ8pXfLL8k&branch=master)](https://travis-ci.com/nsommer/datepicker.js)

All existing datepicker libraries suck, so I wrote my own.

datepicker.js

* **Is not infinitely configurable**, therefore small
* **Requires zero configuration**, it can be enabled and to some extend customized through HTML5 data attributes
* **Uses semantic markup** to take advantage of HTML5's expressiveness
* **Exposes expressive CSS selectors**, to easily swap styles. Write styles for the datepicker that match your UI theme within minutes.
* **Requires jQuery**

## Usage

The datepicker requires a `.datepicker-container` container around the input for easier styling and event delegation. `data-toggle="datepicker"` automatically enables the datepicker on an input field, no other javascript required.

```html
<div class="datepicker-container">
  <input type="date" data-toggle="datepicker" data-position="top">
</div>
```

### Feature implementation status

The base features already work, but some additions I'd like in this project yet need to be implemented.

- [x] Keyboard shortcuts (arrow keys)
- [x] Fix positioning
- [x] Make datepicker widget position configurable via data attribute
- [x] Use `time` tags in the datepicker widget to better expose the semantics in the HTML
- [ ] Decide how to behave on mobile
- [ ] **Maybe:** Add timepicker?
- [ ] Learn writing JavaScript tests with node.js

## Custom styles

The styles for the datepicker widget are found in `scss/_widget.scss`.

The most important style values such as colors, type size etc. are stored in variables with `!default` annotations in `scss/_variables.scss`.

To change the look and feel of the widget - for example to use your application's brand colors - set the corresponding variables **before** importing `datepicker.scss`. This is a popular technique to customize CSS frameworks that use a preprocessor (SASS, LESS).

## JavaScript API

The datepicker is intentionally designed to be used without any custom JavaScript. Enabling and configuring it is done entirely by using HTML5 `data-*` attributes.

However, you can still access the datepicker instance and interact with it, if you need to.

```javascript
var datepicker = Datepicker.find("#my-datepicker")

// Get the selected day as Date object
datepicker.getDate()

// Get the selected date as ISO8601
datepicker.getDateAsString()

// Set a new date
datepicker.setDate(new Date())

// Hide or open it
datepicker.hide()
datepicker.show()

// Rerender the widget (e.g. after modifying the date)
datepicker.rerenderView()

// Write the current date back to the input field
datepicker.updateInputVal()

// Jump a day backwards or forwards
datepicker.previousDay()
datepicker.nextDay()

// Jump a week backwards or forwards
datepicker.previousWeek()
datepicker.nextWeek()

// Jump a month backwards or forwards
datepicker.previousMonth()
datepicker.nextMonth()
```

## Browser Support

Well, IE sucks ...

## Development

```bash
git clone https://github.com/nsommer/datepicker.js.git
cd datepicker
npm install
grunt build
```

The Gruntfile provides some useful tasks you can use.

| Task | Description |
|------|-------------|
| `grunt build` | Builds the js and css files including minified versions and source maps. |
| `grunt watch` | Watches for file changes and rebuilds. |
| `grunt clean` | Cleans shit away. |
| `grunt connect` | Serves the working directory via HTTP at port 8000. |

All tasks, except `connect`, can be suffixed with `:js` or `:css` to only apply the task to the JavaScript or to the Stylesheets respectively.

## License

The source code and documentation of this project is available under the MIT license.
