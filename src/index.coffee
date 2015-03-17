fs = require 'fs'
browserify = require 'browserify'
coffee_reactify = require 'coffee-reactify'
{BrowserifyCompiler} = require 'metaserve-js-browserify'
require('node-cjsx').transform()

class BrowserifyCoffeeJSXCompiler extends BrowserifyCompiler

    default_options:
        ext: 'coffee'
        browserify:
            extensions: ['.coffee']
        browserify_shim: false
        uglify: false

    beforeBundle: (bundler) ->
        bundler = bundler.transform(coffee_reactify)
        if @options.browserify_shim
            bundler = bundler.transform require 'browserify-shim'
        if @options.uglify
            bundler = bundler.transform {global: true}, 'uglifyify'
        return bundler

module.exports = (options={}) -> new BrowserifyCoffeeJSXCompiler(options)

