crud = require "./crud"

middle = {}

middle.findById = (req, res, next) ->

  id = req.param "id"

  return if not id? then next()

  crud.findById id, (err, found) ->
    return if err? then next err, null
    if found? then res.locals.collection = found
    next null, found

middle.findSelf = (req, res, next) ->

  id = if req.user? then req.user._id else null

  return if not id? then next()

  crud.findById id, (err, found) ->
    return if err? then next err, null
    if found? then res.locals.collection = found
    next null, found

middle.find = (req, res, next) ->

  crud.find req, (err, found) ->
    return if err? then next err, null
    if found? then res.locals.collection = found
    next null, found

middle.update = (req, res, next) ->

  id = if req.path == "/users/me" then req.user._id else req.params.id
  
  if req.body.hasOwnProperty('password') and req.body.password == ""
    delete req.body.password

  if req.body.hasOwnProperty('isAdmin')
    req.body.admin = true 
    delete req.body.isAdmin 
  else 
    req.body.admin = false

  return if not id? then next()

  crud.update req, id, (err, updated) ->
    return if err? then next err, null
    req.session.messages = ['Success!']
    if updated? then res.locals.collection = updated
    next null, updated

middle.save = (req, res, next) ->
  
  if req.body.hasOwnProperty('password') == false or req.body.password == ""
    req.session.messages = ['You must specify a password.']
    return next()

  if req.body.hasOwnProperty('isAdmin')
    req.body.admin = true 
    delete req.body.isAdmin 
  else 
    req.body.admin = false

  crud.save req, (err, model) ->
    return if err? then next err, null
    req.session.messages = ['Success!']
    if model? then res.locals.collection = model
    
    res.redirect "/users/#{model._id}"

module.exports = middle