###
# init express sub app
###

express = require "express"
app = module.exports = express()

###
# global middleware
###

assets = require "../shared/assets"
menu = require "../shared/menu"
conf = require "../../conf"

###
# internal app requires
###

middle = require "./middle"
routes = require "./routes"

###
# set app view engine & path
###

app.set "views", conf.views
app.set "view engine", "jade"

###
# app routes
###

app.get "/", assets.middleware, menu.middleware, routes.home