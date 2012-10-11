_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]
_VIEWS = @__get_project_namespace__ [ "Views" ]

_mainModel = undefined
_videoPlayer = undefined

$_videoContainer = undefined
$_imageContainer = undefined
$_coverContainer = undefined
$_closeContainer = undefined
$_nextContainer = undefined
$_lastContainer = undefined
$_textContainer = undefined

class _VIEWS.OverlayView extends _VIEWS.BaseView

  className : 'OverlayView'

  initialize : (callback) ->
    super
    
    $_videoContainer = $ '#overlay-video-container'
    $_imageContainer = $ '#overlay-image-container'
    $_coverContainer = $ '#overlay-cover-container'
    $_closeContainer = $ '#overlay-close-container'
    $_nextContainer = $ '#overlay-next-container'
    $_lastContainer = $ '#overlay-last-container'
    $_textContainer = $ '#overlay-text-container'
    
    _mainModel = _MODELS.mainModel
    _mainModel.on 'change:activeFragments', (model) =>
      @log 'Fragments has changed - update view.'
      
      data = _mainModel.getContent()
      
      if data
        @render data
      else
        _videoPlayer.stopVideo()
        @$el.hide()
      
    _videoPlayer = new _VIEWS.VideoPlayer()
    _videoPlayer.init undefined, =>
      @$el.hide()
      @$el.css 'position', 'absolute'
      @$el.css 'left', 0
      @trigger @EVENTBUS.eventTypes.VIEW_READY, @
    
    @
    
  render: (data) ->
    
    activeSectionId = _mainModel.get 'activeSectionId'
    activeSubpageId = _mainModel.get 'activeSubpageId'
    activeContentId = _mainModel.get 'activeContentId'
    
    if activeContentId is undefined
      route = data[ 0 ][ 'route' ]
      @ROUTER.navigate route, { trigger: true }
      return
    
    @log "render : '#{activeSectionId}' : '#{activeSubpageId}'"
    
    range = _mainModel.getContentRange()
    
    last = range.last
    data = range.active
    next = range.next
    
    # @log 'range', range
    
    if data.videoId
      $_imageContainer.hide()
      $_videoContainer.show()
      _videoPlayer.loadVideoById data.videoId
    else
      html = ich.main_overlay_image_tmpl data
      $_imageContainer.html html
      $_imageContainer.show()
      $_videoContainer.hide()
    
    html = ich.main_overlay_text_tmpl data
    $_textContainer.html html
    
    html = ich.main_overlay_cover_tmpl data
    $_coverContainer.html html                                                                                                                    
    
    html = ich.main_overlay_close_tmpl data
    $_closeContainer.html html
    
    if last                                                                                                              
      html = ich.main_overlay_last_tmpl last
    else
      html = ''
    $_lastContainer.html html                                                                                                              
    
    if next                                                                                                              
      html = ich.main_overlay_next_tmpl next
    else
      html = ''
    $_nextContainer.html html                                                                                                                    
    
    @$el.fadeIn 250
    
    @
    
  resize: (w, h) ->
    @log "width: #{w}, height: #{h}"
    
    @$el.css 'height', h
    $_coverContainer.css 'height', h
    
  @