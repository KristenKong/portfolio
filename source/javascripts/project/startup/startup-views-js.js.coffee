_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ 'Models' ]
_VIEWS = @__get_project_namespace__ [ 'Views' ]

_log = _NS.log "Views"
_mainModel = undefined
_eventBus = undefined
_eventType = undefined

_init = (callback) ->
  
  _log "init"
  
  _mainModel = _MODELS.mainModel
  _eventBus = _NS.eventBus
  _eventType = _eventBus.eventTypes.VIEW_READY
  
  if _NS.Config.touchOS is true then $('body').addClass 'touch'
  
  Nimble.series [
    _initOverlayView
    _initHeaderView
    _initMainView
    _initFooterView
    ], callback
    
  @
  
_initOverlayView = (callback) ->
  view = new _VIEWS.OverlayView
    id : 'overlay'
    el : $ '#overlay'
  
  view.on _eventType, (eventDispatcher) =>
    view.off _eventType
    callback()
    @
    
  _VIEWS.header = view
    
  @  
  
_initHeaderView = (callback) ->
  view = new _VIEWS.HeaderView
    id : 'header'
    el : $ '#header'
  
  view.on _eventType, (eventDispatcher) =>
    view.off _eventType
    @
    
  _VIEWS.header = view
  
  callback()
    
  @  

_initMainView = (callback) ->
  view = new _VIEWS.MainView
    id : 'main'
    el : $ '#main'

  view.on _eventType, (eventDispatcher) =>
    view.off _eventType
    @
    
  _VIEWS.main = view
  
  callback()
  
  @  

_initFooterView = (callback) ->
  view = new _VIEWS.FooterView
    id : 'footer'
    el : $ '#footer'

  view.on _eventType, (eventDispatcher) =>
    view.off _eventType
    @
    
  _VIEWS.footer = view
  
  callback()
  
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init