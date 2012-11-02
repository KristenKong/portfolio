_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ "Helpers", "YouTube" ]

_log = _NS.log "YouTube"

_dataLoader = _NS.DataLoader
_developerKey = undefined

_loadPlaylistById = (id, index, callback) ->
  url = "http://gdata.youtube.com/feeds/api/playlists/#{id}?v=2&alt=json"
  if _developerKey then url = "#{url}&key=#{_developerKey}"
  
  _dataLoader.getJSONP url, (data) ->
    callback data, index
    @
  @

_ob.setDeveloperKey = (developerKey) -> 
  _log "setDeveloperKey : #{developerKey}"
  _developerKey = developerKey
      
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