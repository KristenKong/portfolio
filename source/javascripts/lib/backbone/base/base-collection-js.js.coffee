_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_setup = ->
  @ROUTER = _NS.navigationRouter
  @EVENTBUS = _NS.eventBus
  @

_init = ->
  @addProperties()
  @

class _MODELS.BaseCollection extends Backbone.Collection

  className : "BaseCollection"
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
    
  toJSON : -> 
    items = super
    _.each items, (item) => 
      item.first = false
      item.last = false
      item.middle = true
    first = _.first items 
    first.middle = false
    first.first = true
    last = _.last items 
    last.middle = false
    last.last = true
    items