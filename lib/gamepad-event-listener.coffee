class @GamePadEventListener
  gamepads: {}

  constructor: (@opts) ->
    #@checkForGamePads()
    @_updateInterval = setInterval @checkForGamePads, (opts.pollRate || 100)
    @opts.deadzone ?= 0.2


  checkForGamePads: =>
    currentGamepads = []

    for pad in navigator.webkitGetGamepads()
      continue unless pad?
      previous = @gamepads[pad.index]
      pad = currentGamepads[pad.index] = {axes: pad.axes, buttons: pad.buttons, index: pad.index}
      # Deadzone
      for i in [0..pad.axes.length - 1]
        if Math.abs(pad.axes[i]) < @opts.deadzone
          pad.axes[i] = 0
        else
          pad.axes[i] = (pad.axes[i] - @opts.deadzone) / (1 - @opts.deadzone)


      if previous? == false
        @opts.connect(pad)
      else
        # Checking for changes to the buttons
        for i in [0..pad.buttons.length - 1]
          continue if previous.buttons[i] == pad.buttons[i]
          @opts[if pad.buttons[i] == 1 then "btnDown" else "btnUp"]?(pad,  i)
        # Checking for changes to the axes
        for i in [0..pad.axes.length - 1]
          val = pad.axes[i]
          continue if val == previous.axes[i]
          @opts.axisChange?(pad, i, val)


    for pad in @gamepads
     @opts.remove?(pad) unless currentGamepads[pad.index]?

    @gamepads = currentGamepads
