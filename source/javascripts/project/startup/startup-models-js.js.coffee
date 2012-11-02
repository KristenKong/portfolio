_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_log = _NS.log "Models"

_loadData = (callback) ->
  
  url = _NS.Config.FilePaths.mainData
  
  _NS.DataLoader.getJSON url, ((response) ->
    
    _log "[ Main data loaded ]"
    
    properties = response['root']['item_data']
    
    new _MODELS.MainModel properties, ->
    
      _log "[ Main data modeled ]"

      _MODELS.mainModel = @
      
      callback()
    
    ), ((response) ->
      
      _log "[ Main data failed to load ]"
      
      callback())
      
  @
  

_init = (callback) ->
  
  Nimble.parallel [
    _loadData
  ], callback
  
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init