process.env.NODE_ENV = process.env.NODE_ENV || 'development'

// const environment = require('./environment')
const webpackConfig = require('./base')

module.exports = environment.toWebpackConfig()
