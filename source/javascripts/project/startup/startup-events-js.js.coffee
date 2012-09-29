_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_log = _NS.log "Events"

_init = (callback) ->
  
  _log "init"
  
  _NS.eventBus = new _NS.EventBus
  _NS.navigationRouter = new _NS.NavigationRouter
  
  _initResizeEvent()
  
  callback()

_initResizeEvent = ->
  $(window).resize ->
    w = $(@).width()
    h = $(@).height()
    # @log "width: #{w}, height: #{h}"
    _NS.eventBus.trigger _NS.eventBus.eventTypes.WINDOW_RESIZE, w, h
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init