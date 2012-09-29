_NS = @__get_project_namespace__()
_HELPERS = @__get_project_namespace__ [ "Helpers" ]

_log = _NS.log "Helpers"

_init = (callback) ->
  
  _log "init"
  
  callback()
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init