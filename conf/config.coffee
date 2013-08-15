path = require "path"

module.exports = {
  title: "dhBoilerplate"
  db_path: "testDev"
  host: "localhost"
  key: "dhb.cid"
  port: 3000
  init: true
  public: path.join __dirname, "..", "public"
  uploads: path.join __dirname, "..", "public", "uploads"
  views: path.join __dirname, "..", "views"
}
