# Description:
#   None
#
# Dependencies:
#   "redis": "0.7.2"
#
# Configuration:
#   REDISTOGO_URL
#
# Commands:
#   None
#
# Author:
#   atmos

Url   = require "url"
Redis = require "redis"



# sets up hooks to persist the brain into redis.
module.exports = (robot) ->
  info = process.env.VCAP_SERVICES["redis-2.2"][0].credentials

  client = Redis.createClient(info.port, info.hostname)

  if info.auth
    client.auth info.password

  client.on "error", (err) ->
    robot.logger.error err

  client.on "connect", ->
    robot.logger.debug "Successfully connected to Redis"

    client.get "hubot:storage", (err, reply) ->
      if err
        throw err
      else if reply
        robot.brain.mergeData JSON.parse(reply.toString())
      else
        robot.logger.info "Initializing new redis-brain storage"
        robot.brain.mergeData {}

  robot.brain.on 'save', (data = {}) ->
    client.set 'hubot:storage', JSON.stringify data

  robot.brain.on 'close', ->
    client.quit()