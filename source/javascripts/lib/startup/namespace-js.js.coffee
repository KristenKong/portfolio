_NS = ( @__NAMESPACED_OBJECT__ = {} )

@__get_project_namespace__ = (namespaces = []) -> 
  ns = _NS
  namespace = undefined
  for namespace in namespaces
    ns = ns[namespace] ?= {}
  ns
  
@__set_project_namespace__ = (namespaces = []) ->
  if namespaces.length isnt 0
    ns = {}
    _.each _NS, ( key, val ) -> ns[key] = val

    _NS = @
    _NS = @__get_project_namespace__ namespaces

    _.each ns, ( key, val ) -> _NS[key] = val
    
    # delete @__NAMESPACED_OBJECT__
    @__NAMESPACED_OBJECT__ = undefined
    
  _NS