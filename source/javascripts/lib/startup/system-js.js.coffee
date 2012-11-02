_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'System' ]

_ob.devicePixelRatio = if window.devicePixelRatio then window.devicePixelRatio else 1
_ob.isRetina = _ob.devicePixelRatio > 1
_ob.isTouch = if typeof window.ontouchstart isnt 'undefined' then true else false

_uaMatch = ( pattern ) -> navigator.userAgent.match pattern

_ob.isMobile =
  Android : -> _uaMatch /Android/i
  BlackBerry : -> _uaMatch /BlackBerry/i
  iOS : -> _uaMatch /iPhone|iPod/i
  Opera : -> _uaMatch /Opera Mini/i
  Windows : -> _uaMatch /IEMobile/i
  any : -> _ob.Android() or _ob.BlackBerry() or _ob.iOS() or _ob.Opera() or _ob.Windows()
  
if _ob.isTouch isnt true
  $b = $.browser
  b =
    ie : $b.msie
    mozilla : $b.mozilla
  
  if b.ie
    v = b.version
    if v < 9 then b.ie8 = true else false
    if v < 8 then b.ie7 = true else false
    if v < 7 then b.ie6 = true else false
  
  _ob.isBrowser = b or {}