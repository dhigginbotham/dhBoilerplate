routes = {}

routes.login = (req, res) ->
  res.render "pages/login"

module.exports = routes