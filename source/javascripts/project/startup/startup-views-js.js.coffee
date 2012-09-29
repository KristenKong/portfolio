_NS = @__get_project_namespace__()
_VIEWS = @__get_project_namespace__ [ 'Views' ]
_MEDIA = @__get_project_namespace__ [ 'Media' ]

_log = _NS.log "Views"
_eventBus = undefined
_eventType = undefined

_init = (callback) ->
  
  _log "init"
  
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
    el : 'header'
    $el : $ 'header'
    
  header.on _eventType, (eventDispatcher) =>
    header.off _eventType
    _VIEWS.header = header
    callback()
    @
    
  header.render()
    
  @  

_initMainView = (callback) ->

  main = new _VIEWS.MainView
    id : 'main'
    el : 'div'
    $el : $ 'main'

  main.on _eventType, (eventDispatcher) =>
    main.off _eventType
    _VIEWS.main = main
    callback()
    
  main.render()
  
  @  

_initFooterView = (callback) ->

  footer = new _VIEWS.FooterView
    id : 'footer'
    el : 'footer'
    $el : $ 'footer'

  footer.on _eventType, (eventDispatcher) =>
    footer.off _eventType
    _VIEWS.footer = footer
    callback()
    
  footer.render()
  
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init