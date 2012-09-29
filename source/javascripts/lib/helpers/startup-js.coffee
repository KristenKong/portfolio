_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ "Startup" ]

_log = _NS.log "Startup"
  
_startupFunctions = [ ]

_ob.init = (callback) ->
  
  _startupFunctions.push callback

  Nimble.series _startupFunctions, _cleanup

  @

_ob.add = (startupFunction) ->
  
  _startupFunctions.push startupFunction
  
  @
  
_cleanup = ->
  
  _log "cleanup"
  
  delete _NS.Startup
  
  @