_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_getAttributes = (data) ->
  
  item = data['feed']
  
  title = ""
  if item.media$group.media$title isnt undefined
    title = item.media$group.media$title.$t
    
  description = ""
  if item.media$group.media$description isnt undefined
    description = item.media$group.media$description.$t
  
  if item.media$group.media$thumbnail isnt undefined
    thumbSmall = item.media$group.media$thumbnail[0].url
    thumbLarge = item.media$group.media$thumbnail[1].url
    
  videoCollection = new _MODELS.VideoCollection item.entry
    
  attributes =
    playlistId : item.yt$playlistId.$t
    title : title
    description : description
    thumbSmall : thumbSmall
    thumbLarge : thumbLarge
    videoCollection : videoCollection

  attributes
  
class _MODELS.PlaylistModel extends _MODELS.BaseModel

  className : "PlaylistModel"
  initialize : (data) ->
    # @log "initialize"
    super
    @clear()
    @set ( _getAttributes.call @, data )
    @