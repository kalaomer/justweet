
(
  (window) ->
    retweets = require "./retweets"
    storage = require "../storage"

    setActivationCallback = (data)->
      if data.activation
        retweets.hide()
      else
        retweets.show()

    getStorageCallback = (data) ->
      if data? and data.activation?
        setActivationCallback data        
      else
        setActivationCallback storage.set {"activation": true}

    storage.get getStorageCallback
    storage.onChange -> storage.get getStorageCallback

)(window)