_ = require "lodash"
jade = require "jade"
path = require "path"
fs = require "fs"

navbar = [
  {title: null, icon: "home", href: "/", id: "home"}
  {title: "Users", icon: null, href: "#", id: "users", children: [
    {title: "View Users", icon: "list-alt", href: "/users"}
    {title: "Add User", icon: "plus-sign", href: "/users/new"}
  ], admin: true}
  
  {title: "Login", icon: null, href: "/auth", id: "login", auth: false}
  {title: "Signup", icon: null, href: "/users/new", id: "signup", auth: false}
  {title: "Settings", icon: null, href: "#", id: "users", children: [
    {title: "My Account", icon: "user", href: "/users/me"}
    {title: "Logout", icon: "signout", href: "/logout", id: "logout"}
  ], auth: true}
]

menu = (req, navs, fn) ->

  if typeof fn == "undefined"
    fn = navs
    navs = []

  @_nav = if navs.length > 0 then _.union @_nav, navbar, navs else _.union @_nav, navbar

  @nav = []

  for n in @_nav

    if _.contains(@nav, n.id) == false

      if (req.user? and req.user.hasOwnProperty('admin')) and n.hasOwnProperty('admin') 
        if (n.admin == true) and (req.user.admin == true) then @nav.push n
      
      if req.user? and n.hasOwnProperty('admin') and req.user.admin == true and n.admin == true then @nav.push n

      if n.hasOwnProperty('admin') == false and n.hasOwnProperty('auth') == false then @nav.push n

      if req.user? and n.hasOwnProperty('auth') and n.auth == true then @nav.push n
      
      if req.hasOwnProperty('user') == false and n.hasOwnProperty('auth') and n.auth == false then @nav.push n

      if req.path == n.href then n.active = true else n.active = false

  fn null, @nav

render = (nav, fn) ->

  file = path.join __dirname, "templates", "index.jade"
  html = jade.renderFile file, {menus: nav}

  fn null, html

exports.middleware = (req, res, next) ->

  types = ['get', 'post']

  if types.indexOf(req.method.toLowerCase()) > -1
    new menu req, (err, nav) ->
      render nav, (err, html) ->
        res.locals.menu = html
        next()
  else next()