asset = require "assets-middleware"

scripts = [
  {src: '//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/css/bootstrap.min.css', name: 'bootstrap.css', where: 'head', uri: null, type: 'css', exclude: null}
  {src: '//netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css', name: 'font-awesome.css', where: 'head', uri: null, type: 'css', exclude: null}
  {src: '/css/style.css', name: 'style.css', where: 'head', uri: null, type: 'css', exclude: null}
  {src: '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js', name: 'jquery.js', where: 'foot', uri: null, type: 'js', exclude: null}
  {src: '//netdna.bootstrapcdn.com/bootstrap/3.0.0-rc1/js/bootstrap.min.js', name: 'bootstrap.js', where: 'foot', uri: null, type: 'js', exclude: null}
  {src: '/js/angular.js', name: 'angular.js', where: 'foot', uri: null, type: 'js', exclude: null}
]

middleware = (req, res, next) ->
  assets = new asset req, {assets: scripts}

  assets.make (embed) ->
    res.locals.assets = embed
    next()

exports.middleware = middleware