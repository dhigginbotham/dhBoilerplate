passport = require "passport"
LocalStrategy = require("passport-local").Strategy

User = require "../../models/user"

passport.serializeUser (user, done) ->
  done null, user._id

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    done err, user

# local strategy
passport.use new LocalStrategy (username, password, done) ->
  
  User.findOne username: new RegExp("^" + username + "$", 'i'), (err, user) ->
    return if err? then done err
    return if not user? then done null, false, message: "Unknown user " + username

    user.comparePassword password, (err, isMatch) ->
      return if err? then done err
      if isMatch

        user.last_login.push(Date.now())

        user.save (err) ->
          return if err? then done err
          return done null, user
      else
        done null, false, message: "Invalid Password"