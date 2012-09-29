_NS = @__get_project_namespace__()
_NS.Random ?= {}

_log = _NS.log "Random"

_ob = _NS.Random

_HELPERS.Random.string = (length = 5) ->
  
  t = ''
  possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  l = possible.length
  i = 0
  
  while i < length
    t += possible.charAt( Math.floor( Math.random() * l ) )
    i++

  t