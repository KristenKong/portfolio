_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'Location' ]

_loc = window.location

_ob.protocol = _loc.protocol
_ob.port = if _loc.port then ":#{_loc.port}" else ""
_ob.url = "#{_ob.protocol}//#{_loc.hostname}#{_ob.port}"