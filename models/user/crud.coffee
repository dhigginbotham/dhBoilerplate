User = require "./index"
_ = require "lodash"

crud = {}

crud.findById = (id, fn) ->

  User.findById id, (err, found) ->
    return if err? then fn err, null
    return if found? then fn null, found

crud.find = (req, fn) ->

  query = req.params.id or {}

  User.find query, (err, found) ->
    return if err? then fn err, null
    return if found? then fn null, found

crud.findOne = (query, fn) ->

  User.findOne query, (err, found) ->
    return if err? then fn err, null
    return if found? then fn null, found

crud.update = (req, id, fn) ->

  User.mergeUpdate {_id: id}, req.body, (err, updated) ->
    return if err? then fn err, null
    fn null, updated

  # User.findById id, (err, found) ->
  #   return if err? then fn err, null
    
  #   if found?
  #     _.extend found, req.body
  #     updated = found

  #     found.save (err) ->
  #       return if err? then fn err, null
  #       if updated? then fn null, updated

crud.save = (req, fn) ->

  model = new User(req.body)

  model.save (err) ->
    return if err? then fn err, null
    return if model? then fn null, model

module.exports = crud