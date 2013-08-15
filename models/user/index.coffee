db = require "../db"
Schema = require("mongoose").Schema
ObjectId = Schema.Types.ObjectId

conf = require "../../conf"

helpers = require "../plugins"

bcrypt = require "bcrypt"
SALT_WORK_FACTOR = 10

UserSchema = new Schema
  first_name: String
  last_name: String
  email: String
  username: String
  password: String
  admin: Boolean
  updated_date: [type: Date, default: Date.now]
  created_date: type: Date, default: Date.now
  last_login: [type: Date, default: Date.now]
  ip: String
  login_count: type: Number, default: 0


UserSchema.plugin(helpers)
UserSchema.pre "save", (next) ->
  user = this

  if user.isModified "last_login"
    user.login_count = user.login_count + 1

  if !user.isModified "password"
    return next()
  else
    bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
      return if err then next(err)
      bcrypt.hash user.password, salt, (err, hash) ->
        return if err then next(err)
        else
          user.password = hash
          next()

UserSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, this.password, (err, isMatch) ->
    return if err then cb(err)
    cb null, isMatch

User = module.exports = db.model "User", UserSchema

if conf.init == true
  db.once "open", () ->

    User.findOne username: /admin/i, (err, seed) ->
      return console.log err if err?
      
      colorz = conf.colors()

      if !seed
        initSeed = new User
          username: "admin"
          password: conf.secret()
          email: "admin@localhost.it"
          first_name: "Admin"
          last_name: "Webmin"
          admin: true

        initSeed.save (err) ->
          return err if err
      else
        console.log "\r\n\r\n" + colorz.red + "Heads up! Set the init option to false, because the seed user already exists!" + colorz.reset + "\r\n\r\n"
