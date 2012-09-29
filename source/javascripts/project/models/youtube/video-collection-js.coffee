_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

class _MODELS.VideoCollection extends _MODELS.BaseCollection

  className : "VideoCollection"
  model : _MODELS.VideoModel
  initialize : -> 
    super
    # @log "initialize"
    @