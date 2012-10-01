_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_log = _NS.log "Routes"

_init = (callback) ->
  
  _log "init"
  
  router = _NS.navigationRouter
  matches = _NS.Config.Url.Matches
  mainModel = _NS.Models.mainModel
  
  router.route '*default', 'home', -> 
    @log 'A home route has triggered.'
    # Update
    _MODELS.mainModel.default()
    @
  
  # TODO : [RKP] : There's gotta be a more elegant way to do this
  router.route matches.getSection(), 'section', (activeSectionId) -> 
    @log "Section route '#{activeSectionId}' has triggered."
    # Reset
    _MODELS.mainModel.attributes['activeContentId'] = undefined
    _MODELS.mainModel.attributes['activeSubpageId'] = undefined
    # Update
    _MODELS.mainModel.set 'activeSectionId', activeSectionId
    @
    
  router.route matches.getSubpage(), 'subpage', (activeSectionId, activeSubpageId) -> 
    @log "Subpage route '#{activeSubpageId}' has triggered."
    # Reset
    _MODELS.mainModel.attributes['activeContentId'] = undefined
    # Update
    _MODELS.mainModel.attributes['activeSectionId'] = activeSectionId
    _MODELS.mainModel.set 'activeSubpageId', activeSubpageId
    @
    
  router.route matches.getContent(), 'content', (activeSectionId, activeSubpageId, activeContentId) -> 
    @log "Content route '#{activeContentId}' has triggered."
    # Update
    _MODELS.mainModel.attributes['activeSectionId'] = activeSectionId
    _MODELS.mainModel.attributes['activeSubpageId'] = activeSubpageId
    _MODELS.mainModel.set 'activeContentId', activeContentId
    @
  
  callback()
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init