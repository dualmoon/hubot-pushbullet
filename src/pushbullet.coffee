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

  latestPush =
    limit: 1
    modified_after: 0

  if process.env.HUBOT_PUSHBULLET_STREAM
    console.log "Pushbullet streaming is #{if process.env.HUBOT_PUSHBULLET_STREAM then 'on' else 'off'}"
    pbStream = pushbullet.stream()
    pbStream.on 'tickle', (type) ->
      lastPush = pushbullet
      pushbullet.history lastPush, (err, res) ->
        if not err
          console.log "Got a tickle. Here's the last push's title: #{res.pushes[0].title}"
    pbStream.connect()

  robot.respond /(?:pb|pushbullet) last/, (msg) ->

    pushbullet.history latestPush, (err, res) ->
      if not err
        push = res.pushes[0]
        msg.send "Last push was \"#{push.title}\" from #{push.sender_name}"
