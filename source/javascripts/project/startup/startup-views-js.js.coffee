_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ 'Models' ]
_VIEWS = @__get_project_namespace__ [ 'Views' ]
_MEDIA = @__get_project_namespace__ [ 'Media' ]

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
    _initHeaderView
    _initMainView
    _initFooterView
    ], callback
    
  @
  
_initVideoPlayer = (callback) -> 
  # _VIEWS.videoPlayer =  new _MEDIA.VideoPlayer()
  # _VIEWS.videoPlayer.init undefined, callback
  callback()
  @
  
_initHeaderView = (callback) ->
  header = new _VIEWS.HeaderView
    id : 'header'
    el : $ '#header'
  
  header.on _eventType, (eventDispatcher) =>
    header.off _eventType
    @
    
  _VIEWS.header = header
  
  callback()
    
  @  

_initMainView = (callback) ->
  main = new _VIEWS.MainView
    id : 'main'
    el : $ '#main'

  main.on _eventType, (eventDispatcher) =>
    main.off _eventType
    @
    
  _VIEWS.main = main
  
  callback()
  
  @  

_initFooterView = (callback) ->
  footer = new _VIEWS.FooterView
    id : 'footer'
    el : $ '#footer'

  footer.on _eventType, (eventDispatcher) =>
    footer.off _eventType
    @
    
  _VIEWS.footer = footer
  
  callback()
  
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init