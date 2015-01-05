noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  MoonPosition = require '../components/MoonPosition.coffee'
else
  MoonPosition = require 'noflo-suncalc/components/MoonPosition.js'

describe 'MoonPosition component', ->
  c = null
  latitude = null
  longitude = null
  altitude = null
  azimuth = null
  distance = null
  beforeEach ->
    c = MoonPosition.getComponent()
    latitude = noflo.internalSocket.createSocket()
    longitude = noflo.internalSocket.createSocket()
    altitude = noflo.internalSocket.createSocket()
    azimuth = noflo.internalSocket.createSocket()
    distance = noflo.internalSocket.createSocket()
    c.inPorts.latitude.attach latitude
    c.inPorts.longitude.attach longitude
    c.outPorts.altitude.attach altitude
    c.outPorts.azimuth.attach azimuth
    c.outPorts.distance.attach distance

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.latitude).to.be.an 'object'
      chai.expect(c.inPorts.longitude).to.be.an 'object'
    it 'should have needed output ports', ->
      chai.expect(c.outPorts.altitude).to.be.an 'object'
      chai.expect(c.outPorts.azimuth).to.be.an 'object'
      chai.expect(c.outPorts.distance).to.be.an 'object'
    it 'should output altitude', (done) ->
      altitude.once 'data', (res) ->
        chai.expect(Math.abs(res)).to.be.above 0
        done()
      latitude.send 0
      longitude.send 0
    it 'should output azimuth', (done) ->
      altitude.once 'data', (res) ->
        chai.expect(Math.abs(res)).to.be.above 0
        done()
      latitude.send 0
      longitude.send 0
    it 'should output distance', (done) ->
      altitude.once 'data', (res) ->
        chai.expect(Math.abs(res)).to.be.above 0
        done()
      latitude.send 0
      longitude.send 0