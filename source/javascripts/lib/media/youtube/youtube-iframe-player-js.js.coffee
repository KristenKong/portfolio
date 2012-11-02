_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'YT', 'IFramePlayer' ]

# Player Props
_playerProps = undefined

# States
_states = new _ob.States
_state = _states.UNSTARTED
# Qualities
_qualities = new _ob.Qualities
_quality = _qualities.MEDIUM
# Errors
_errors = new _ob.Errors
_error = null
# Errors
_playbackProgress = new _ob.PlaybackProgress

# Proprties
_win = window
_doc = _win.document
_player = undefined
_videoId = undefined

# Flags
_isReady = false
_isLoading = false
_isPaused = false

_readyChecks = 60
_readyChecker = undefined

_log = _NS.log 'YT IFramePlayer'

_loadAPI = ->
  tag = _doc.createElement 'script'
  tag.src = 'http://www.youtube.com/player_api'
  firstScriptTag = _doc.getElementsByTagName('script')[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag
  @

_updateVideo = (videoId, autoplay = undefined) ->
  _log 'Update Video ', videoId
  
  _videoId = videoId
  
  if autoplay is true or autoplay is false
    _playerProps.autoplay = autoplay
    
  if _player isnt undefined
    _isLoading = true
    _player.loadVideoById _videoId, autoplay
    
  @

_checkAutoPlaying = ->
  if _isLoading
    _isLoading = false
    if _playerProps.autoplay is true
      _log 'Auto playing.'
      _ob.playVideo();
    else
      _log 'Auto pausing.'
      _ob.pauseVideo()
      
  @

_trackLoadingProgress = ->
  bl = 0
  bt = 0
  p = 0
  
  # 
  # i = setInterval (->
  #   bl = _player.getVideoBytesLoaded()
  #   bt = _player.getVideoBytesTotal()
  #   p = bl / bt
  #   
  #   _log "................Loaded ( #{bl} kb ) of ( #{bt} kb ) or ( #{p} % )"
  # 
  #   if p < 1
  #     _playerProps.onLoadProgress.call null, p
  #   else
  #     clearInterval i)
  #   , 2000
    
  @

_onYouTubePlayerAPIReady = ->
  _log 'API ready'
  
  _win.onYouTubePlayerAPIReady = null
  
  _log '_playerProps_playerProps_playerProps_playerProps', _playerProps

  params =
    playerVars :
      enablejsapi : 1
      autoplay : if _playerProps.autoplay is true then 1 else 0
      controls : if _playerProps.controls is true then 1 else 0
      autohide : if _playerProps.autohide is true then 1 else 0
      showinfo : if _playerProps.showinfo is true then 1 else 0
      rel : _playerProps.rel + "&wmode=transparent"
      wmode: "opaque"

      
    width : _playerProps.width
    height : _playerProps.height
    
    events :
      onReady : _onReady
      onError : _onError
      onStateChange : _onStateChange
      onPlaybackQualityChange : _onPlaybackQualityChange
      
  # Value may not be set on API Ready state
  if _videoId then params.videoId = _videoId
  
  # TODO: RKP: Detect 500, 404 on timer?
  _player = new YT.Player _playerProps.playerTargetId, params
  
    
  _readyChecker = setInterval (=>
    
    _log 'Check ready'
    
    el = $("#{_playerProps.playerTargetId}").is("iframe")
    
    
    # _log "Element : #{el}"
    # _log "Ready Checks : #{_readyChecks}"
    # _log "Is Ready? : #{_isReady}"
    # _log "_player.loadVideoById : #{_player.loadVideoById}"
  
    if ( el and _player.loadVideoById ) or _isReady or _readyChecks-- is 0
      _log 'Is ready'
      _readySuccess()
    else
      _log 'Not ready'
    )
    , 50
  
  @
  
_readySuccess = ->
  
  _log 'Ready success'
  
  if _isReady then return  
      
  _isReady = true
  
  clearInterval _readyChecker

  if _playerProps?.onLoadProgress isnt undefined then _trackLoadingProgress()

  _playerProps.onReady?.call null
  
  @

_onReady = (event) ->
  
  _log 'Player ready event'
  
  _readySuccess()
  
  @

_onError = (event) ->
  _error = event.data
  
  msg = ""

  switch _error
    when _errors.INVALID_PARAMETERS
      # 2
      msg = "Invalid Parameters"
    when _errors.VIDEO_NOT_FOUND
      # 100
      msg = "Video Not Found"
    when _errors.PLAYBACK_NOT_ALLOWED, _errors.PLAYBACK_NOT_ALLOWED_2
      # 101 & 150
      msg = "Playback Not Allowed"
    else
      msg = "Code Unknown"
  
  _log "*** Error *** (#{_error}) #{msg}"
  
  _playerProps.onError?.call null, _error
  
  @

_onStateChange = (event) ->
  _state = event.data
    
  msg = ""
  
  switch _state
    when _states.UNSTARTED
      # -1
      _stopProgressTimer()
      msg = "Video Unstarted"
    when _states.ENDED
      # 0
      msg = "Video Ended"
      $('#pl-arrow-right').trigger 'click', true
      # _stopProgressTimer()
      _playerProps.onPlaybackProgress?.call null, _playbackProgress.PERCENT_100
    when _states.PLAYING
      # 1
      msg = "Video Playing"
      _startProgressTimer()
      _checkAutoPlaying()
    when _states.PAUSED
      # 2
      msg = "Video Paused"
      _stopProgressTimer()
    when _states.BUFFERING
      # 3
      msg = "Video Buffering"
    when _states.VIDEO_QUEUED
      # 5
      msg = "Video Queued"
    else
      msg = "Video State Unknown"

  _log "State : (#{_state}) #{msg}"

  _playerProps.onStateChange?.call null, _state
  
  @

_onPlaybackQualityChange = (event) ->
  _quality = event.data

  _log "Video Quality : #{_quality}"

  _playerProps.onPlaybackQualityChange?.call null, _quality
  
  @
  
_timer = undefined
_progress = 0
_progressMilestone25 = false
_progressMilestone50 = false
_progressMilestone75 = false
_progressMilestone100 = false
_timerCount = 0
  
_startProgressTimer = ->
  _stopProgressTimer()
  _timerCount =0
  if _timer is undefined
    _timer = setInterval (->
      _progress = _player.getCurrentTime() / _player.getDuration()
      # @log _progress
      _checkProgressMilestone()
      ), 2000
  
_checkProgressMilestone = ->
  # just in case if it runs too many times...
  _timerCount +=1
  if _timerCount > 1500 
    _stopProgressTimer()
  # @log "...........................timer is running"
  if _progress > .25 and _progress < .5 and _progressMilestone25 is false
    _progressMilestone25 = true
    _progressMilestone50 = _progressMilestone75 = false
    _playerProps.onPlaybackProgress?.call null, _playbackProgress.PERCENT_25, _progress
  else if _progress > .5 and _progress < .75 and _progressMilestone50 is false
    _progressMilestone50 = true
    _progressMilestone25 = _progressMilestone75 = false
    _playerProps.onPlaybackProgress?.call null, _playbackProgress.PERCENT_50, _progress
  else if _progress > .75 and _progress < .98 and _progressMilestone75 is false
    _progressMilestone75 = true
    _progressMilestone25 = _progressMilestone50 = false
    _playerProps.onPlaybackProgress?.call null, _playbackProgress.PERCENT_75, _progress
  else if _progress > .98 and _progress <= 1 and _progressMilestone100 is false
    _progressMilestone100 = true
    _progressMilestone25 = _progressMilestone50 = _progressMilestone75 = false
    _playerProps.onPlaybackProgress?.call null, _playbackProgress.PERCENT_100, _progress
    
  
_stopProgressTimer = ->
  _progress = 0
  _progressMilestone25 = false
  _progressMilestone50 = false
  _progressMilestone75 = false
  _progressMilestone100 = false
  if _timer
    clearInterval _timer
  _timer = undefined
  
# Public methods
_ob.init = (playerProps) ->
  
  _log 'init'
  
  _playerProps = playerProps or new _ob.Initializer
  
  _win.onYouTubePlayerAPIReady = _onYouTubePlayerAPIReady;

  _loadAPI()
  
  @

_ob.loadVideoById = (videoId, autoplay) ->
  _updateVideo videoId, autoplay
  
  @

_ob.playVideo = ->
  _log "PLAY VIDEO"

  if not _isPaused then return
  _isPaused = false
  # _startProgressTimer()
  _player.playVideo()
  
  @

_ob.pauseVideo = ->  
  _log "PAUSE VIDEO"
  
  if _isPaused then return
  
  _isPaused = true
  _player.pauseVideo()
  
  @

_ob.stopVideo = ->
  _log "STOP VIDEO", _player
  _stopProgressTimer()
  _player.pauseVideo()
  _player.stopVideo()
  
  @

_ob.seekTo = (seconds, allowSeekAhead) ->
  _log "SEEK VIDEO : #{seconds}"
  _player.seekTo seconds, allowSeekAhead
  
  @

_ob.getProgress = ->
  return _progress
  
  @

_ob.getState = ->
  return _state
  
  @

_ob.setWidth = (value) ->
  _ob.setDimensions value, null
  
  @

_ob.setHeight = (value) ->
  _ob.setDimensions null, value
  
  @

_ob.setDimensions = (width = _playerProps.width, height = _playerProps.height) ->
  _playerProps.width = width
  _playerProps.height = height

  if _player
    iframe = _doc.getElementById "#{_playerProps.playerTargetId}"
    iframe.width = width
    iframe.height = height
      
  @
