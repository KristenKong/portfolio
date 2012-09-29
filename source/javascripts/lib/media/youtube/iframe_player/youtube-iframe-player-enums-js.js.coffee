_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'YT', 'IFramePlayer' ]

_ob.States = ->
  
  @UNSTARTED = -1
  @ENDED = 0
  @PLAYING = 1
  @PAUSED = 2
  @BUFFERING = 3
  @VIDEO_QUEUED = 5
  
  @
  
_ob.Qualities = ->

  @SMALL = "small"
  @MEDIUM = "medium"
  @LARGE = "large"
  @HD720 = "hd720"
  @HD1080 = "hd1080"
  @HIGHRES = "highres"
  
  @
  
_ob.Errors = ->
  
  @INVALID_PARAMETERS = 2
  @VIDEO_NOT_FOUND = 100
  @PLAYBACK_NOT_ALLOWED = 101
  @PLAYBACK_NOT_ALLOWED_2 = 150
  
  @
  
_ob.PlaybackProgress = ->
  
  @PERCENT_100 = "percent_100"
  @PERCENT_75 = "percent_75"
  @PERCENT_50 = "percent_50"
  @PERCENT_25 = "percent_25"
  
  @