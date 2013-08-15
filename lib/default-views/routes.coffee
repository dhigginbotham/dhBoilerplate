routes = {}

###
# routes for `default-views` maybe
# this could go inside of `shared`
###

routes.home = (req, res) ->
  res.render "pages/home"

module.exports = routes