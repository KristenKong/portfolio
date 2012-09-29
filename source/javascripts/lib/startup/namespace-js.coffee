_NS = ( @DEFAULT_NAMESPACE_OBJECT = {} )

@__get_project_namespace__ = (namespaces = []) -> 
  ns = _NS
  namespace = undefined
  for namespace in namespaces
    ns = ns[namespace] ?= {}
  ns
  
@__set_project_namespace__ = (namespaces = []) ->
  if namespaces.length isnt 0
    _NS = @
    _NS = @__get_project_namespace__ namespaces
    
    # delete @DEFAULT_NAMESPACE_OBJECT
    @DEFAULT_NAMESPACE_OBJECT = undefined
    
  _NS