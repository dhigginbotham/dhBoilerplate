form = require "forms-middleware"

middle = {}

middle.login = (req, res, next) ->

  login =
    method: "post"
    title: "Login Form"
    id: "login"
    action: "login"
    forms: [
      {name: "username", label: "Username", value: null}
      {type: "password", name: "password", label: "Password", value: null}
    ]

  forms = new form req, login
  
  forms.render (err, form) ->
    res.locals.loginForm = form
    next()

module.exports = middle
