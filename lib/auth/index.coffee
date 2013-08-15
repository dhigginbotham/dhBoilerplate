express = require "express"
app = module.exports = express()

conf = require "../../conf"
assets = require "../shared/assets"
menu = require "../shared/menu"

middle = require "./middle"
routes = require "./routes"
forms = require "./forms"

passport = require "passport"

app.set "views", conf.views
app.set "view engine", "jade"

app.get "/auth", assets.middleware, forms.login, menu.middleware, routes.login

app.post "/auth", (req, res, next) ->

  passport.authenticate("local", (err, user, info) ->
    return if err? then next err, null
    
    unless user
      req.session.messages = [info.message]
      return res.redirect "/auth"
    else
      req.logIn user, (err) ->
        return if err? then next err, null
        res.redirect "/"

  ) req, res, next

app.get "/logout", (req, res) ->
  req.logout()
  res.redirect "/"