# Description:
#   Generates help commands for Hubot.
#
# Commands:
#   hubot help - Displays all of the help commands that Hubot knows about.
#   hubot help <query> - Displays all help commands that match <query>.
#
# URLS:
#   /hubot/help
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

helpContents = (name, commands) ->

  """
<html>
  <head>
  <title>#{name} Help</title>
  <style type="text/css">
    body {
      background: #2c3e50;
      color: #2ecc71 ;
      font-family: Helvetica, Arial, sans-serif;
      width: 960px;
      margin: 20px auto;
    }
    .commands {
      font-size: 14px;
    }
    p {
      border-bottom: 1px solid #eee;
      margin: 6px 0 0 0;
      padding-bottom: 5px;
    }
    p:first-child {
      border-top: 1px solid #eee;
    }
  </style>
  </head>
  <body>
    <div class="commands">
      #{commands}
    </div>
  </body>
</html>
  """

module.exports = (robot) ->
  robot.respond /help\s*(.*)?$/i, (msg) ->
    msg.send 'http://' + process.env.HUBOT_HOSTNAME + '/hubot/help'

  robot.router.get '/hubot/help', (req, res) ->
    cmds = robot.helpCommands()
    emit = "<p>#{cmds.join '</p><p>'}</p>"

    emit = emit.replace /hubot/ig, "<b>#{robot.name}</b>"

    res.setHeader 'content-type', 'text/html'
    res.end helpContents robot.name, emit
