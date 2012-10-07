_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined
$_activeMenuItem = undefined

class _VIEWS.HeaderView extends _VIEWS.BaseView

  className : 'HeaderView'

  initialize : ->
    super
    
    _mainModel = _MODELS.mainModel
    
    @hide()
    
    data = _mainModel.getSection()
    html = ich.header_menu_tmpl { data : data }
    @$el.find('#header-menu').html html
    
    _mainModel.on 'change:activeSectionId', (model) =>
      @log 'A Section has changed - update view.'
      @render()
      @show 250
      
    @trigger @EVENTBUS.eventTypes.VIEW_READY, @
    
    @
    
  render: ->
    @log 'render'
    
    if $_activeMenuItem
      $_activeMenuItem.removeClass 'header-menu-item-active'
      $_activeMenuItem.addClass 'header-menu-item-inactive'
    
    activeSectionId = _mainModel.get 'activeSectionId'
    
    $_activeMenuItem = $ "##{activeSectionId}"
    $_activeMenuItem.removeClass 'header-menu-item-inactive'
    $_activeMenuItem.addClass 'header-menu-item-active'
    
    @
    
  @