(
  (window, document, console) ->
    log = (message)->
      console.log = console.__proto__.log

      console.log message

    deleteRetweet = (tweet) ->
      retweeter = tweet.getAttribute "data-retweeter"

      if retweeter?
        tweet.remove()
        log "#{retweeter}'s retweet is deleted."

    window.onload = () ->
      tweets = document.querySelectorAll(".tweet")
      
      deleteRetweet tweet for tweet in tweets

    handleTweets = (sumaries) ->
      tweetSummary = sumaries[0]

      for newTweet in tweetSummary.added
        deleteRetweet newTweet

    tweetObserver = new MutationSummary({
      callback: handleTweets,
      queries: [{ element: '[data-retweeter]' }]
    })

)(window, document, console)