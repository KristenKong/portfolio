_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined

class _VIEWS.MainView extends _VIEWS.BaseView

  className : 'MainView'

  initialize : ->
    super
    
    _mainModel = _MODELS.mainModel
    
    @
    
  render: ->
    
    
    @trigger @EVENTBUS.eventTypes.VIEW_READY, @
    
    @
    
  @