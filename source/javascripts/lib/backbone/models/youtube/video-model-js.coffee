_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
  
_getText = (field) ->
  if field then field["$t"] else undefined
  
_getAttributes = (data) ->
  item = data
  
  group = item["media$group"]
  thumb = group["media$thumbnail"]
  videoId = _getText group["yt$videoid"]
  
  attributes =
    # playlistid : playlistId
    # id : index
    route : _NS.Config.Url.Routes.getVideo videoId
    duration : group["yt$duration"]["seconds"]
    videoId : videoId
    title : _getText group["media$title"]
    description : _getText group["media$description"]
    tags : _getText group["media$keywords"]
    thumbSmall : thumb[0].url
    thumbLarge : thumb[1].url
    thumbSlide : [
      thumb[2].url
      thumb[3].url
      thumb[4].url
    ]

  attributes

class _MODELS.VideoModel extends _MODELS.BaseModel

  className : "VideoModel"
  initialize : (data) ->
    super
    # @log "initialize", data
    @clear()
    @set ( _getAttributes.call @, data )
    @     
    

  
    
      
