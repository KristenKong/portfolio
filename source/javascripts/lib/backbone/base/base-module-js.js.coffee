_NS = @__get_project_namespace__()
_MODULES = @__get_project_namespace__ [ "Modules" ]
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_setup = ->
  @ROUTER = _NS.navigationRouter
  @EVENTBUS = _NS.eventBus
  @

_init = ->
  @addProperties()
  @addModels()
  @addViews()
  @addEvents()
  @renderViews()
  @
  
class _MODULES.BaseModule
    
  className : "BaseModule"
  NS : _NS
  MODELS : _MODELS
  
  initialize : ->
    
    @log = _NS.log @className
    # @log "initialize"
    
    _setup.call @
    _init.call @
    
    @
    
  addProperties : ->
    # @log "addProperties"
    @

  addModels : ->
    # @log "addModels"
    @
    
  addViews : ->
    # @log "addViews"
    @
    
  addEvents : ->
    # @log "addEvents"
    @EVENTBUS.on @EVENTBUS.eventTypes.WINDOW_RESIZE, (width, height) =>
      # @log "#{w}, #{h}"
      @resize width, height
      @
    @
     
  renderViews : ->
    # @log "renderViews"
    
    @
  
  resize : (width, height) ->
    # @log "resize: #{width}, #{height}"
    @