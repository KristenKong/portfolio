_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined

class _VIEWS.HeaderView extends _VIEWS.BaseView

  className : 'HeaderView'

  initialize : ->
    super
    
    _mainModel = _MODELS.mainModel
    
    @
    
  render: (callback) ->
    items = _mainModel.getSection()
    html = ich.header_menu_tmlp { items : items }
    @$el.html html
    
    @trigger @EVENTBUS.eventTypes.VIEW_READY, @
    
    @
    
  @