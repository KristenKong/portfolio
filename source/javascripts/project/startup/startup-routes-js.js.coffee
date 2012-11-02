_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_log = _NS.log "Routes"
_mainModel = undefined

_updateMainModel = (activeSectionId, activeSubpageId = undefined, activeContentId = undefined) ->
  _log "#{activeSectionId}/#{activeSubpageId}/#{activeContentId}"
  _mainModel.set 'activeSectionId', activeSectionId
  _mainModel.set 'activeSubpageId', activeSubpageId
  _mainModel.set 'activeContentId', activeContentId
  _mainModel.set 'activeFragments', [ activeSectionId, activeSubpageId, activeContentId ]

_init = (callback) ->
  
  _log "init"
  
  _mainModel = _MODELS.mainModel
  
  router = _NS.navigationRouter
  matches = _NS.Config.Url.Matches
  
  router.route '*default', 'home', -> _mainModel.default()
  router.route matches.getSection(), 'section', _updateMainModel
  router.route matches.getSubpage(), 'subpage', _updateMainModel
  router.route matches.getContent(), 'content', _updateMainModel
  
  callback()
  
_ob = @__get_project_namespace__ [ "Startup" ]
_ob.add _init