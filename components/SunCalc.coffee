# File: components/Forwarder.coffee
noflo = require "noflo"

exports.getComponent = ->
  component = new noflo.Component
  component.description = "Sun and moon calculations"

  # Register ports and event handlers
  component.inPorts.add 'in', datatype: 'all', (event, payload) ->
    switch event
      when 'data'
        # Forward data when we receive it.
        # Note: send() will connect automatically if needed
        component.outPorts.out.send data
      when 'disconnect'
        # Disconnect output port when input port disconnects
        component.outPorts.out.disconnect()
  component.outPorts.add 'out', datatype: 'all'

  component # Return new instance