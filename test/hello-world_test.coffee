chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'pushbullet', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/pushbullet')(@robot)

  it 'responds to "pb last" or "pushbullet last"', ->
    expect(@robot.respond).to.have.been.calledWithMatch sinon.match( (val) ->
      val.test /pushbullet last/
      val.test /pb last/
    )
