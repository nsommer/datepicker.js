# datepicker.js

All existing datepicker libraries suck, so I wrote my own.

datepicker.js

* **Is not infinitely configurable**, therefore small
* **Requires zero configuration**, it can be enabled and to some extend customized through HTML5 data attributes
* **Uses semantic markup** to take advantage of HTML5's expressiveness
* **Exposes expressive CSS selectors**, to easily swap styles. Write styles for the datepicker that match your UI theme within minutes.
* **Requires jQuery**

## Usage

This is the markup for an input that uses a datepicker.

```html
<input type="datetime-local" data-toggle="datepicker" data-position="top">
```

This is the markup that builds the datepicker itself.

```html
<div class="datepicker">
  <div class="datepicker-titlebar">
    <button type="button" class="datepicker-control" data-action="prev"></button>
    <span class="datepicker-month"></span>
    <button type="button" class="datepicker-control" data-action="next"></button>
  </div>
  <ul class="datepicker-days-header">
    <li>Mon</li>
    ...
  </ul>
  <ul class="datepicker-days">
    <li class="datepicker-day"><time datetime=""></time></li>
    ...
  </ul>
</div>
```

## Browser Support

Well, IE sucks ...

## Documentation

**TODO**

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
