noflo = require 'noflo'
SunCalc = require '../vendor/suncalc.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'sun-o'
  c.description = 'Moon position altitude and azimuth'

  c.inPorts.add 'latitude',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.latitude = payload
      c.compute()

  c.inPorts.add 'longitude',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.longitude = payload
      c.compute()

  c.outPorts.add 'altitude',
    datatype: 'number'

  c.outPorts.add 'azimuth',
    datatype: 'number'

  c.outPorts.add 'distance',
    datatype: 'number'

  c.compute = ->
    return unless c.latitude? and c.longitude?
    c.obj = SunCalc.getMoonPosition new Date(), c.latitude, c.longitude
    if c.outPorts.altitude.isAttached()
      c.outPorts.altitude.send c.obj.altitude
    if c.outPorts.azimuth.isAttached()
      c.outPorts.azimuth.send c.obj.azimuth
    if c.outPorts.distance.isAttached()
      c.outPorts.distance.send c.obj.distance

  c 