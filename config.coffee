path = require("path")

env = process.env.NODE_ENV or "development"
ou = if (env is "development") then "builds/development" else "builds/production"

module.exports =
  env: env
  dev: (env is "development")
  prod: (env is "production")
  rootDir: __dirname
  srcDir: path.join(__dirname, "app")
  outputDir: ou
