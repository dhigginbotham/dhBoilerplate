###
# init express application
###

express = require "express"
app = express()

server = require("http").createServer(app);

###
# require modules
###

path = require "path"
conf = require "./conf"

###
# app global settings
###

app.set "port", conf.port
app.use express.compress()
app.use conf.locals
app.use express.favicon(false)

### 
# environment settings
###

# by default express wants to look for `process.env.NODE_ENV` and it should
# either be `development` or `production`.

if process.env.NODE_ENV == "development"
  app.use express.logger "dev"
  app.use express.errorHandler {dumpExceptions: true, showStack: true}
if process.env.NODE_ENV == "production"
  app.use express.logger()

###
# cookies, sessions, files and forms
###

app.use express.static conf.public
app.use express.bodyParser {keepExtensions: true}
app.use express.cookieParser()

###
# mongodb backed session store
###

SessionStore = require("session-mongoose")(express)
app.use express.session
  store: new SessionStore 
    url: conf.db_uri
    interval: 1000 * 60000
  secret: conf.secret()
  key: conf.key
  cookie: maxAge: 1000 * 60000

###
# patch req.flash
###
app.use require "./lib/shared/growl"

###
# app global middlewares
###
pass = require "./lib/passport"
defaults = require "./lib/default-views"
users = require "./lib/users"
auth = require "./lib/auth"
menu = require "./lib/shared/menu"

# passport
passport = require "passport"

app.use passport.initialize()
app.use passport.session()
app.use conf.patchLocals

# facebook-oauth

###
# mounted routes
###

### csrf middleware ###
app.use express.csrf()

### default routes ###
app.use defaults

### auth routes ###
app.use auth

### user routes ###
app.use users

#   /users
#   /users/new
#   /users/edit

###
# fire up the bass cannon
###

server.listen app.get("port"), () ->
  console.log conf.title + " starting on port " + app.get("port")

###
# be clean about exiting
###

process.on "SIGINT", ->
  process.exit(0)
