_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined
$_articles = undefined
$_active = undefined

class _VIEWS.MainView extends _VIEWS.BaseView

  className : 'MainView'

  initialize : ->
    super
    
    $_articles = @$el.find 'article'
    $_articles.hide()
    
    _mainModel = _MODELS.mainModel
    _mainModel.on 'change:activeSectionId', (model) =>
      @log 'A Section has changed - update view.'
      @render()
    
    @
    
  render: ->
    
    $_articles.hide()
    
    activeSectionId = _mainModel.get 'activeSectionId'
    
    @log "render : '#{activeSectionId}'"
    
    $_active = @$el.find "#main-#{activeSectionId}"
    
    template = ich["main_#{activeSectionId}_tmpl"]
    
    if template
      data = _mainModel.getSubpage()
      html = template { data : data }
      $_active.html html
    
    $_active.show()
    
    @trigger @EVENTBUS.eventTypes.VIEW_READY, @
    
    @
    
  @