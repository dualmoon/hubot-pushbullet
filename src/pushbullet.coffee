# Description:
#   <placeholder>
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <placeholder>
#
# Author:
#   dualmoon

if not process.env.HUBOT_PUSHBULLET_API_KEY
  console.log "HUBOT_PUSHBULLET_API_KEY was not set! This plugin won't work!"
else
  apiKey = process.env.HUBOT_PUSHBULLET_API_KEY
##check an env var to see if we want to open a websocket stream (HUBOT_PUSHBULLET_STREAM?)


PushBullet = require 'pushbullet'
pushbullet = new PushBullet apiKey

module.exports = (robot) ->
  if process.env.HUBOT_PUSHBULLET_STREAM
    console.log "Pushbullet streaming is #{if process.env.HUBOT_PUSHBULLET_STREAM then 'on' else 'off'}"
    pbStream = pushbullet.stream()
    pbStream.on 'push', (push) ->
      console.log "got a push: #{push.title}"
    pbStream.on 'tickle', (type) ->
      console.log "PB: tickle! (#{type})"
    pbStream.connect()

  robot.respond /(?:pb|pushbullet) last/, (msg) ->
    options =
      limit: 1,
      modified_after: 0

    pushbullet.history options, (err, res) ->
      if not err
        push = res.pushes[0]
        msg.send "Last push was \"#{push.title}\" from #{push.sender_name}"
