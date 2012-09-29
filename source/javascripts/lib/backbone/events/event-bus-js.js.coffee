_NS = @__get_project_namespace__()
_NS.EventBus = ->
  
  _.extend @, Backbone.Events
  
  @eventTypes = 
    WINDOW_RESIZE : 'eventTypes.WINDOW_RESIZE'
    MODEL_READY : 'eventTypes.MODEL_READY'
    VIEW_READY : 'eventTypes.VIEW_READY'
    
  @