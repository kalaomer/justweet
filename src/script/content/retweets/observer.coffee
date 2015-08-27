
console = require "console"
MutationSummary = require "mutation-summary"


class Observer
  constructor: (@tweetHandler)->
    @status = false
    
    # Create observer then disconnect
    @observe()
    @_observer.disconnect()

  observe: ->
    @_observer = new MutationSummary({
      callback: (sumaries) =>
        @handleTweets(sumaries)
      queries: [{ element: '[data-retweeter]' }]
    })

  handleTweets: (sumaries) ->
    tweetSummary = sumaries[0]

    for newTweet in tweetSummary.added
      @tweetHandler newTweet

  disconnect: ->
    if @status is true
      @_observer.disconnect()
      @status = false

      console.info "observer disconnected"

  connect: ->
    if @status is false
      @_observer.reconnect()
      @status = true

      console.info "observer started"

module.exports = Observer

