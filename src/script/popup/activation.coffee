
storage = require "../storage"

class Activation
  constructor: ->
    @element = document.querySelector("#activation")

    @setElement()

  status: (value)->
    if value?
      @element.checked = value

      storage.set {activation: value}

      console.log "activation changed: #{@status()}"

    return @element.checked

  setElement: ->
    storage.get (data) =>
      if ! data.activation?
        return @status true

      @status data.activation

    @element.addEventListener "change", =>
      @status @element.checked

module.exports = Activation