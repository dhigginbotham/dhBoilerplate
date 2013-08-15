Form = require "forms-middleware"

middle = {}

middle.saveUser = (req, res, next) ->

  col = if res.locals.hasOwnProperty('collection') then res.locals.collection else {}

  account =
    method: "post"
    title: "Edit Account"
    id: "account"
    action: null
    forms: [
      {type: "text", name: "username", id: "username", name: "username", label: "Username", value: col.username}
      {type: "password", name: "password", id: "password", name: "password", label: "Password"}
      {type: "text", name: "first", id: "first", name: "first_name", label: "First Name", value: col.first_name}
      {type: "text", name: "last", id: "last", name: "last_name", label: "Last Name", value: col.last_name}
      {type: "text", name: "email", id: "email", name: "email", label: "Email", value: col.email}
      {type: "checkbox", name: "isAdmin", id: "isAdmin", name: "isAdmin", label: "#{if col.admin == true then 'Keep as Admin?' else 'Make Admin?'}", value: col.admin}
      {type: "hidden", name: "updated_date", id: "updated_date", name: "updated_date", value: Date.now()}
    ]

  forms = new Form req, account

  forms.render (err, form) ->
    res.locals.userForm = form
    return next()

middle.newUser = (req, res, next) ->

  col = if res.locals.hasOwnProperty('collection') then res.locals.collection else {}

  account =
    method: "post"
    title: "Create Account"
    id: "account"
    action: null
    forms: [
      {type: "text", name: "username", id: "username", name: "username", label: "Username"}
      {type: "password", name: "password", id: "password", name: "password", label: "Password"}
      {type: "text", name: "first", id: "first", name: "first_name", label: "First Name"}
      {type: "text", name: "last", id: "last", name: "last_name", label: "Last Name"}
      {type: "text", name: "email", id: "email", name: "email", label: "Email"}
      {type: "checkbox", name: "isAdmin", id: "isAdmin", name: "isAdmin", label: "#{if col.admin == true then 'Keep as Admin?' else 'Make Admin?'}", value: col.admin}
      {type: "hidden", name: "updated_date", id: "updated_date", name: "updated_date", value: Date.now()}
    ]

  forms = new Form req, account

  forms.render (err, form) ->
    res.locals.userForm = form
    return next()

module.exports = middle
