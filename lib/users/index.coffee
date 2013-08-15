express = require "express"
app = module.exports = express()

conf = require "../../conf"
assets = require "../shared/assets"
menu = require "../shared/menu"

collections = require "../../models/user/middle"

middle = require "./middle"
routes = require "./routes"
forms = require "./forms"

passport = require "passport"
ensure = require "../passport/middle"

app.set "views", conf.views
app.set "view engine", "jade"

prefix = "/users"
id = "/:id"

app.use 

app.get prefix, ensure.isAdmin, assets.middleware, menu.middleware, collections.find, routes.view

app.get prefix + "/me", ensure.isUser, assets.middleware, menu.middleware, collections.findSelf, forms.saveUser, routes.account

app.get prefix + "/new", assets.middleware, menu.middleware, forms.newUser, routes.account

app.post prefix + "/new", collections.save, (req, res) ->
  res.redirect "back"

app.get prefix + id, ensure.isAdmin, assets.middleware, menu.middleware, collections.findById, forms.saveUser, (req, res) ->
  res.render "pages/account"

app.post prefix + id, ensure.isAdmin, collections.update, (req, res) ->
  res.redirect "back"

# app.get prefix + "/:id", assets.middleware, forms.account, routes.user