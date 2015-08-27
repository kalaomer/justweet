
# Twitter doesn't allow console commands, so we need to prepare console

methodNames = ["log", "warn", "info", "debug"]

methods = {}

createMethod = (methodName) ->
  console[methodName] = console.__proto__[methodName]

  return (args...) ->
    console[methodName] args...


for methodName in methodNames
  methods[methodName] = createMethod(methodName)

module.exports = methods