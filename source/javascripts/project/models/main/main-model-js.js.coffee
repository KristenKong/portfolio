_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_itemCollection = undefined

_getActiveSubpageItems = () ->
  match = @get 'activeSectionId'
  model = _itemCollection.find (model) -> ( model.get 'fragment' ) is match
  # @log 'activeSectionId', match
  # @log 'activeYearModel', model
  model.get 'itemCollection'

_getActiveContentItems = () ->
  match = @get 'activeSubpageId'
  model = ( _getActiveSubpageItems.call @ ).find (model) -> ( model.get 'fragment' ) is match
  # @log 'activeSectionId', match
  # @log 'activeYearModel', model
  ( model.get 'playlistCollection' ).at 0
  
_getDomIds = (ids) ->
  _ids = []
  _.each ids, (id) => _ids.push ( @get id )
  _ids.join '-'

class _MODELS.MainModel extends _MODELS.BaseModel
  
  className : 'MainModel'
  activeSectionId : undefined
  activeSubpageId : undefined
  activeContentId : undefined
  
  initialize : (data) ->
    super data
    
    _itemCollection = @get 'itemCollection'
    
    @log _itemCollection
    
    @
  
  default : ->
    # Reset
    @attributes['activeContentId'] = undefined
    @attributes['activeSubpageId'] = undefined
    # Update
    @set 'activeSectionId', ( _itemCollection.at 0 ).get 'fragment'
    @
    
  getSection : -> _itemCollection.toJSON()
  getSubpage : -> ( _getActiveSubpageItems.call @ ).toJSON()
  getContent : -> ( ( _getActiveContentItems.call @ ).get 'videoCollection' ).toJSON()
  getContentById : (id) -> _.find @getVideos(), (model) -> model['videoId'] is videoId
  
  getActiveSectionDomId : -> _getDomIds.call @, [ 'activeSectionId' ] 
  getActiveSubpageDomId : -> _getDomIds.call @, [ 'activeSectionId', 'activeSubpageId' ]
  getActiveContentDomId : -> _getDomIds.call @, [ 'activeSectionId', 'activeSubpageId', 'activeContentId' ]
    
  getContentRoutePrefix : -> 
    # TODO : [RKP] : This is kinda hack, might try to clean up.
    routes = _NS.Config.Url.Routes
    section = routes.getSection( @get 'activeSectionId' )
    subpage = routes.getSubpage( @get 'activeSubpageId' )
    
    "#{section}#{subpage}"
