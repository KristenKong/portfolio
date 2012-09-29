_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_log = _NS.log "Models"

_loadData = (callback) ->
  
  url = _NS.Config.FilePaths.mainData
  
  _NS.DataLoader.getJSON url, ((response) ->
    
    _log "[ Main data loaded ]"
    
    eventType = _NS.eventBus.eventTypes.MODEL_READY
    
    data = response['root']['item_data']
    
    _MODELS.mainModel = new _MODELS.MainModel data
    _MODELS.mainModel.on eventType, => 
    
      _MODELS.mainModel.default()
      
      _log "[ Main data modeled ]"
      
      callback()
    
    ), ((response) ->
      
      _log "[ Main data failed to load ]"
      
      callback())
  
  
_addModels = (callback) ->
  
  callback()

_init = (callback) ->
  
  Nimble.parallel [
    _loadData
    _addModels
  ], callback
  
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init