_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ "YT", "Helpers" ]

_log = _NS.log "YT Helpers"

_dataLoader = _NS.DataLoader

_getPlaylistUrl : (playlistId) -> 
  key = if _ob.developerKey then "&key=#{_ob.developerKey}" else ''
  "http://gdata.youtube.com/feeds/api/playlists/#{playlistId}?v=2&alt=json#{key}"

_loadPlaylistById = (id, index, callback) ->
  url = _getPlaylistUrl id
  _dataLoader.getJSONP url, (data) ->
    callback data, index
    @
  @
  
_ob.developerKey = undefined

_ob.getPlaylists = (playlistIds, callback) ->
  count = total = playlistIds.length
  index = 0
  playlists = []
  id = undefined

  while index < total
    id = playlistIds[index]
    _loadPlaylistById id, index, (data, index) =>
      playlists.splice index, 0, data
      if --count is 0 then callback playlists
    index++
  @  