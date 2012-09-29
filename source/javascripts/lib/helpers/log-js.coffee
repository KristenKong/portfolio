# usage: log('inside coolFunc', this, arguments);
# paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/

if typeof window.console is "undefined" then window.console = log: ->

_NS = @__get_project_namespace__()

_NS.Config ?= {}

# Added some fancy stuff
if _NS.Config.touchOS is true
  _NS.log = (id) -> -> log(arg for arg in arguments)
else
  _NS.log = (id) -> -> log "[#{id}]", arg for arg in arguments

@log = ->
  return if _NS.Config.debug is false
  log.history = log.history or []
  log.history.push arguments
  if @console
    arguments.callee = arguments.callee.caller
    newarr = [].slice.call(arguments)
    (if typeof console.log is "object" then log.apply.call(console.log, console, newarr) else console.log.apply(console, newarr))

# make it safe to use console.log always
(b) ->
  c = ->
  d = "assert,count,deventBusug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,timeStamp,profile,profileEnd,time,timeEnd,trace,warn".split(",")
  a = undefined

  while a = d.pop()
    b[a] = b[a] or c

do ->
  try
    console.log()
    return window.console
  catch err
    return window.console = {}