_ = require "lodash"
 
module.exports = exports = crudifyMongoose = (schema, options) ->
  # eventually I'll need access to some global options, 
  # let's keep a mental reference for that.
  extended = if options? then options else {}
 
  ###
 
  `findBySlug` :  much like findById, however it will only return
                  one item, as slug's in today's usage are unique. 
 
  ###
 
  schema.statics.findBySlug = findBySlug = (slug, callback) ->
 
    self = @
 
    query = if slug? then {slug: slug} else null
 
    if query? then @findOne query, (err, found) ->
      return if err? then callback err, null
      callback null, found
 
  ###
 
  `mergeUpdate` :  will also concat arrays, weeeee. 
 
  ###
 
  schema.statics.mergeUpdate = mergeUpdate = (queryObject, toUpdate, callback) ->
 
    # queryObject ie: {_id: someId}
    # toUpdate ie: {object of key,val to update}
    # callback ie: callback(errorHere,nextHere);
 
    self = @

    return if typeof callback == "undefined" and _.isFunction(toUpdate) == true
      callback "you must provide an update object"
 
    if typeof queryObject != "undefined" then @findOne queryObject, (err, found) ->
 
      return if err? then callback err, null
 
      if found? then _.merge found, toUpdate, (a, b) ->
        return if _.isArray(a) then a.concat(b) 
        else if _.isArray(b) then b.push(a)
        else `undefined`
 
      found.save (err) ->
        return if err? then callback err, null
        callback null, found
 
    else callback "you must provide a query object, ie: {_id: someId}", null