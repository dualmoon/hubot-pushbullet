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
  robot.respond /(?:pb|pushbullet) last/, (msg) ->
    options =
      limit: 1,
      modified_after: 0
    
    msg.send "Pushbullet Pong."
    
    pushbullet.history options, (err, res) ->
      if not err
        console.log(res)
