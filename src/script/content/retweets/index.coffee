
console = require "console"

Observer = require "./observer"

class Retweets
  constructor: ->
    @observer = new Observer @handleNewTweet

  show: ->
    @showAllElements()
    @observer.disconnect()

  hide: ->
    @hideAllElements()
    @observer.connect()

  handleNewTweet: (tweet) =>
    @hideElement tweet

  all: ->
    return document.querySelectorAll(".tweet")

  hideElement: (tweet) ->
    retweeter = tweet.getAttribute "data-retweeter"

    if retweeter?
      tweet.classList.add "hide-tweet"

      console.log "#{retweeter}'s retweet is hidden."

  hideAllElements: ->
    @hideElement tweet for tweet in @all()

  showAllElements: ->
    for tweet in @all()
      tweet.classList.remove "hide-tweet"

module.exports = new Retweets