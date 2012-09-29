_NS = @__get_project_namespace__()
_VIEWS = @__get_project_namespace__ [ 'Views' ]
_MEDIA = @__get_project_namespace__ [ 'Media' ]

_log = _NS.log "Views"

_init = (callback) ->
  
  _log "init"
  
  if _NS.Config.touchOS is true then $('body').addClass 'touch'
  
  Nimble.series [
    _initVideoPlayer
    _initMainView
    ], callback
    
  @
  
_initVideoPlayer = (callback) -> 
  # _VIEWS.videoPlayer =  new _MEDIA.VideoPlayer()
  # _VIEWS.videoPlayer.init undefined, callback
  callback()
  @
  
_initMainView = (callback) ->
  callback()
  @
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init