_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'YT', 'IFramePlayer' ]

_ob.Props = ->
  # Player params
  @playerTargetId = "video-player-target"
  @width = "645"
  @height = "390"
  @autoplay = 0
  @controls = 1
  @autohide = 1
  @showinfo = 0
  @related = 0
  # Event handlers
  @onReady = undefined
  @onError = undefined
  @onStateChange = undefined
  @onLoadProgress = undefined
  @onPlaybackProgress = undefined
  @onPlaybackQualityChange = undefined
  
  @