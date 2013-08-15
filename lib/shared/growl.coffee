###
# patch for deprecated req.flash stuff
###

module.exports = (req, res, next) ->

  if req.session.hasOwnProperty('messages')
    res.locals.flash = req.session.messages
    delete req.session.messages

  next()
