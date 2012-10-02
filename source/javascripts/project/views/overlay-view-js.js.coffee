_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined
$_overlay = undefined
$_videoContainer = undefined
$_imageContainer = undefined
$_textContainer = undefined
$_coverContainer = undefined
_videoPlayer = undefined

class _VIEWS.OverlayView extends _VIEWS.BaseView

  className : 'OverlayView'

  initialize : (callback) ->
    super
    
    $_overlay = $ '#overlay'
    $_videoContainer = $ '#overlay-video-container'
    $_imageContainer = $ '#overlay-image-container'
    $_textContainer = $ '#overlay-text-container'
    $_coverContainer = $ '#overlay-cover-container'
    
    @$el.hide()
    @$el.on 'click', (eventDispatcher) => @$el.hide()
    
    _mainModel = _MODELS.mainModel
    _mainModel.on 'change:activeSubpageId', (model) =>
      @log 'A Subpage has changed - update view.'
      @render()
      
    _videoPlayer = new _VIEWS.VideoPlayer()
    _videoPlayer.init undefined, =>
      @trigger @EVENTBUS.eventTypes.VIEW_READY, @
    
    @
    
  render: ->
    
    activeSectionId = _mainModel.get 'activeSectionId'
    activeSubpageId = _mainModel.get 'activeSubpageId'
    
    @log "render : '#{activeSectionId}' : '#{activeSubpageId}'"
    
    data = _mainModel.getContent()[ 0 ]
    
    @log data
    
    if data.videoId
      $_imageContainer.hide()
      $_videoContainer.show()
    else
      html = ich.main_overlay_image_tmpl data
      $_imageContainer.html html
      $_imageContainer.show()
      $_videoContainer.hide()
    
    html = ich.main_overlay_text_tmpl data
    $_textContainer.html html
    
    html = ich.main_overlay_cover_tmpl data
    $_coverContainer.html html                                                                                                                    
    
    @$el.fadeIn 250
    
    @
    
  resize: (w, h) ->
    @log "width: #{w}, height: #{h}"
    
    $_overlay.css 'height', h
    $_coverContainer.css 'height', h
    
  @