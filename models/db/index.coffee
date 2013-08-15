mongoose = require "mongoose"
conf = require "../../conf"

###
# paginate
###

paginate = require('paginate')({
    mongoose: mongoose
});

###
# mongo debug
###

mongoose.set "debug", true

###
# db fanciness
###

db = module.exports = mongoose.createConnection conf.db_uri

# db.on "error", console.error.bind console, "connection error:"

process.on "SIGINT", ->
  db.close()
  