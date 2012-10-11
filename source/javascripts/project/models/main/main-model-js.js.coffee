_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_itemCollection = undefined

_getSubpageItems = (activeSectionId) ->
  model = _itemCollection.find (model) -> ( model.get 'fragment' ) is activeSectionId
  model.get 'itemCollection'

_getContentItems = (activeSectionId, activeSubpageId) ->
  model = ( _getSubpageItems.call @, activeSectionId ).find (model) -> ( model.get 'fragment' ) is activeSubpageId
  model.get 'itemCollection'
  
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
  
  getSubpage : -> 
    activeSectionId = @get 'activeSectionId'
    if activeSectionId
      return ( _getSubpageItems.call @, activeSectionId ).toJSON()
    else
      return undefined
      
  getContent : -> 
    activeSectionId = @get 'activeSectionId'
    activeSubpageId = @get 'activeSubpageId'
    if activeSectionId and activeSubpageId
      return ( _getContentItems.call @, activeSectionId, activeSubpageId ).toJSON()
    else 
      return undefined
      
  getContentRange : (range = 3) -> 
    activeContentId = @get 'activeContentId'
    content = @getContent()
    if content
      return _.find content, (val, key) =>
        @log val
        @log key
        val
    else 
      return undefined
      
  getContentLast : -> 
    activeSectionId = @get 'activeSectionId'
    activeSubpageId = @get 'activeSubpageId'
    if activeSectionId and activeSubpageId
      return ( _getContentItems.call @, activeSectionId, activeSubpageId ).toJSON()
    else 
      return undefined
    
    
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
