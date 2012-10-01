_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_checkPlaylistCollection = ->
  eventType = @EVENTBUS.eventTypes.MODEL_READY
  playlistId = @get 'playlist'
  
  if playlistId isnt undefined
    _NS.YT.Helpers.getPlaylists [playlistId], (playlists) =>
      @set 'playlistCollection', ( new _MODELS.PlaylistCollection playlists )
      @collection.trigger eventType, @
  else
    @collection.trigger eventType, @
    
  @
  
_checkVideo = ->
  if ( @get 'contentType' ) is 'video'
    @set 'videoId', ( @get 'fragment' )
  @

class _MODELS.ItemModel extends _MODELS.BaseModel

  className : "ItemModel"
  addProperties : ->
    super
    
    _checkPlaylistCollection.call @
    _checkVideo.call @
    
    @

  @

