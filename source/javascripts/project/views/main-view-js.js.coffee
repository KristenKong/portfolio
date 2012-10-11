_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined
$_active = undefined

_updateSection = ->
  activeSectionId = _mainModel.get 'activeSectionId'
    
  @log "render : '#{activeSectionId}'"
  
  $_active = @$el.find "#main-#{activeSectionId}"
  
  template = ich["main_#{activeSectionId}_tmpl"]
  
  if template
    data = _mainModel.getSubpage()
    html = template { data : data }
    $_active.html html
  
  $_active.show 250
  
  @trigger @EVENTBUS.eventTypes.VIEW_READY, @
  
  @

class _VIEWS.MainView extends _VIEWS.BaseView

  className : 'MainView'

  initialize : ->
    super
    
    @hide()
    
    @$el.find('article').hide()
    
    _mainModel = _MODELS.mainModel
    _mainModel.on 'change:activeSectionId', (model) =>
      @log 'Section has changed - update view.'
      @render()
      @show 250, 125
    
    @
    
  render: ->
    
    if $_active
      $_active.hide 125, =>
        _updateSection.call @
    else
      _updateSection.call @
    
  @