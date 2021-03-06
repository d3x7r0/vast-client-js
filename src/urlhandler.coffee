xhr = require './urlhandlers/xmlhttprequest'
flash = require './urlhandlers/flash'
xdr = require './urlhandlers/xdr'

class URLHandler
    @get: (url, options, cb) ->
        # Allow skip of the options param
        if not cb
            cb = options if typeof options is 'function'
            options = {}

        if options.response?
            # Trick: the VAST response XML document is passed as an option
            cb(null, options.response)
        else if options.urlhandler?.supported()
            # explicitly supply your own URLHandler object
            return options.urlhandler.get(url, options, cb)
        else if not window?
            # prevents browserify from including this file
            return require('./urlhandlers/' + 'node').get(url, options, cb)
        else if xhr.supported()
            return xhr.get(url, options, cb)
        else if flash.supported()
            return flash.get(url, options, cb)
        else if xdr.supported()
            return xdr.get(url, options, cb)
        else
            return cb()

module.exports = URLHandler
