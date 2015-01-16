class FlashURLHandler
    @xhr: ->
        xhr = new window.flensed.flXHR() if window.flensed && window.flensed.flXHR
        return xhr

    @supported: ->
        try
            window.flensed.flXHR.module_ready()
            return true
        catch
            return false

    @get: (url, options, cb) ->
        if typeof options is 'function'
            cb = options
            options = null

        try
            xhr = this.xhr()
            xhr.open('GET', url)
            xhr.timeout = options.timeout or 0
            xhr.withCredentials = options.withCredentials or false
            xhr.send()
            xhr.onreadystatechange = ->
                if xhr.readyState == 4
                    cb(null, xhr.responseXML)
        catch
            cb()

module.exports = FlashURLHandler
