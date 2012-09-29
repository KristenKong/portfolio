#= require ./vendor/_require-js
#= require ./lib/startup/namespace-js
#= require ./project/config/_require-js
#= require ./lib/_require-js
#= require ./project/_require-js

_NS = @__get_project_namespace__()
_STARTUP = @__get_project_namespace__ [ "Startup" ]

_log = _NS.log "App"
$_doc = $ document

$_doc.ready =>
  _log 'Document ready'
  _log '>>> Startup begin >>>'
  _STARTUP.init -> 
    _log '<<< Startup complete <<<'
    _log 'Start history'
    Backbone.history.start()
  @