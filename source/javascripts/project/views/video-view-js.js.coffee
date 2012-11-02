_NS = @__get_project_namespace__()
_VIEWS = @__get_project_namespace__ ['Views']

_log = _NS.log 'VideoPlayer'
_player = _NS.YT.IFramePlayer
_isPlayerReady = false
_videoId = undefined

class _VIEWS.VideoPlayer
  
  init : (videoId, callback) ->
    _log "Video Player init : #{videoId}"
    
    playbackProgress = new _player.PlaybackProgress
    playerProps = new _player.Props
    
    playerProps.width = "100%"
    playerProps.height = "100%"
    playerProps.autoplay = true
    
    playerProps.onReady = =>
      _log "Video Player is ready"
      
      _isPlayerReady = true
      
      @setDimensions playerProps.width, playerProps.height
      
      if _videoId isnt undefined
        _log "player is ready, loading video #{_videoId}"
        
        @loadVideoById _videoId
        
        _videoId = undefined
      
      callback()
      
      @  
    
    playerProps.onPlaybackChange = (state) =>
      _log "On Playback Change : #{state}"
      @
    
    playerProps.onLoadProgress = (progress) =>
      _log "On Load Progress : #{progress}"
      @
  
    playerProps.onPlaybackProgress = (percent) =>
      _log "On Playback Progress : #{playbackProgress}"
  
      if percent is playbackProgress.PERCENT_25
        _log "Video is 25% complete : #{_videoTitle}"
      else if percent is playbackProgress.PERCENT_50
        _log "Video is 50% complete : #{_videoTitle}"
      else if percent is playbackProgress.PERCENT_75
        _log "Video is 75% complete : #{_videoTitle}"
      else if percent is playbackProgress.PERCENT_100
        _log "Video is 100% complete : #{_videoTitle}"
      @
  
    _player.init playerProps
      
    @
  
  loadVideoById : (videoId) ->
    _log "Load video by id : #{videoId}"
    
    # TODO : [RKP] : Move this inside player logic
    if _isPlayerReady
      _log "Load video by id, player is ready"
      _player.loadVideoById videoId
      
    else
      # Player isn't ready so we'll store the videoId for when it is
      _log "Load video by id, player isn't ready, queue video"
      _videoId = videoId
        
    @
    
  stopVideo : ->
    _log "Stop video"
    if _isPlayerReady
      _player.stopVideo()
    @
      
  setDimensions : (width, height) ->
    _log "setDimensions: #{width}, #{height}"
    _player.setDimensions width, height
    @
