routes = {}

routes.view = (req, res) ->
  res.render "pages/view"

routes.account = (req, res) ->
  res.render "pages/account"

module.exports = routes