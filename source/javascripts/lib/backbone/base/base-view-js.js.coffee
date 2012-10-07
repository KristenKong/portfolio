_NS = @__get_project_namespace__()
_VIEWS = @__get_project_namespace__ [ "Views" ]
_MODELS = @__get_project_namespace__ [ "Models" ]
_HELPERS = @__get_project_namespace__ [ "Helpers" ]


class _VIEWS.BaseView extends Backbone.View
  
  className : "BaseView"
  NS : _NS
  MODELS : _MODELS
  ROUTER : undefined
  EVENTBUS : undefined
  visibility : true
    
  initialize : ->
    @className = if @el then "#{@className} ##{@el.id}" or "#{@className} .#{el.className}" else @className
    @log = _NS.log @className
    @ROUTER = _NS.navigationRouter
    @EVENTBUS = _NS.eventBus
    @touchOS = _NS.Config.touchOS
    
    _NS.eventBus.bind _NS.eventBus.eventTypes.WINDOW_RESIZE, (w, h) => @resize w, h
    
    @
  
  hide: (speed = 0, delay = 0) ->
    @log 'hide'
    # if @visibility is false then return @
    if speed isnt 0
      @$el.delay(delay).fadeOut(speed, => @visibility = false)
    else
      @$el.delay(delay).hide()
      @visibility = false
    @
  
  show: (speed = 0, delay = 0) ->
    @log 'show'
    # if @visibility is true then return @
    if speed isnt 0
      @$el.delay(delay).fadeIn(speed, => @visibility = true)
    else
      @$el.delay(delay).show()
      @visibility = true
    @
    
  resize: (w, h) ->
    # @log "width: #{w}, height: #{h}"
  
  initResize: ->
    w = $(window).width()
    h = $(window).height()
    @resize w,h