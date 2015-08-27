
class Storage
  get: (args...)->
    if chrome?
      chrome.storage.local.get args...

  set: (data, callback)->
    if chrome?
      chrome.storage.local.set data, callback

    return data

  onChange: (callback)->
    if chrome?
      chrome.storage.onChanged.addListener callback

module.exports = new Storage