noflo = require 'noflo'
SunCalc = require '../vendor/suncalc.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'sun-o'
  c.description = 'Moon illumination'

  c.inPorts.add 'timeanddate',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.timeanddate = payload
      c.compute()

  c.outPorts.add 'fraction',
    datatype: 'number'

  c.outPorts.add 'phase',
    datatype: 'number'

  c.outPorts.add 'angle',
    datatype: 'number'

  c.compute = ->
    return unless c.timeanddate?
    c.obj = SunCalc.getMoonIllumination c.timeanddate
    if c.outPorts.fraction.isAttached()
      c.outPorts.fraction.send c.obj.fraction
    if c.outPorts.phase.isAttached()
      c.outPorts.phase.send c.obj.phase
    if c.outPorts.angle.isAttached()
      c.outPorts.angle.send c.obj.angle

  c