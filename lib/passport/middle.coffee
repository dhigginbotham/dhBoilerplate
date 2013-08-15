exports.isUser = isUser = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    req.session.messages = ['You must be logged in for that']
    res.redirect "/auth"

exports.isAdmin = isAdmin = (req, res, next) ->
  if req.isAuthenticated()
    if req.user? and req.user.role == "admin" || req.user.admin == true
      next()
    else
      req.session.messages = ['Lacking account credentials']
      res.redirect "/"
  else 
    req.session.messages = ['You must be logged in for that']
    res.redirect "/auth"