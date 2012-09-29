_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

class _NS.NavigationRouter extends Backbone.Router

  className : "NavigationRouter"
  
  routes : {}
  
  initialize : (options) ->
    @log = _NS.log "#{@className}"