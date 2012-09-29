_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_setup = ->
  @ROUTER = _NS.navigationRouter
  @EVENTBUS = _NS.eventBus
  @
  
_init = ->
  @addProperties()
  @  
  
class _MODELS.BaseRelationalModel extends Backbone.RelationalModel

  className : "BaseRelationalModel"
  NS : _NS
  MODELS : _MODELS
  ROUTER : undefined
  EVENTBUS : undefined
  
  initialize : ->
  
    @log = _NS.log @className
    # @log "initialize"
    
    _setup.call @
    _init.call @
    
    @
    
  addProperties : ->
    # @log "addProperties"
    @
    
_MODELS.BaseRelationalModel.setup()