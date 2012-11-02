_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_setup = ->
  @ROUTER = _NS.navigationRouter
  @EVENTBUS = _NS.eventBus
  @
  
_init = ->
  @addEvents()
  @addProperties()
  @  
  
class _MODELS.BaseModel extends Backbone.Model

  className : "BaseModel"
  NS : _NS
  MODELS : _MODELS
  
  initialize : ( data, @onReady ) ->

    @log = _NS.log @className

    # @log "initialize"
    
    super data

    _setup.call @
    _init.call @

    @

  addEvents : ->
    # @log "addEvents"
    @

  addProperties : ->
    # @log "addProperties"
    @

  ready : ->
    # @log 'ready'
    @onReady?()
    @

  @