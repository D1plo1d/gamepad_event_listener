## Preamble

These docs are really breif because I had about 10 minutes to write them. If you 
need help, give me a shout or look at the source.

To install this library download `gamepad-event-listener.js` and add it to 
your html with a script tag.

## API

The GamePadEventListener constructor takes a object of listener functions:

`new GamePadEventListener([listeners])`

### Event Listeners (listeners)

* *connect* - called when a gamepad is connected (press square on the ps3 controller to connect)
* *axisChange* - called whenever a joystick is moved
* *btnDown* - called each time a button on the gamepad is pressed
* *btnUp* - called each time a button on the gamepad is released

## Example Useage

```javascript
$(function() {

  new GamePadEventListener({
    connect: function (gamepad) {
      console.log("connected!");
    },
    axisChange: function (gamepad, axis, val) {
      console.log("axis changed "+axis+" to: "+val);
    },
    btnDown: function (gamepad, button) {
      console.log("button down: " + button);
    },
    btnUp: function (gamepad, button) {
      console.log("button up: " + button);
    }
  });

});
```