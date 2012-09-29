_NS = @__get_project_namespace__()
_NS.Screen ?= {}

_log = _NS.log "Screen"

_NS.Screen.getFullscreenSize = (obj, ext, margin) ->
  ow = obj.original_width
  oh = obj.original_height
  tw = obj.target_width
  th = obj.target_height
  oRatio = ow/oh
  tRatio = tw/th
  if tRatio is oRatio
    width = tw
    height = th
    left = 0
    top = 0
  else if tRatio > oRatio
    width = tw
    height = tw/oRatio
    left = 0
    top = (th - tw/oRatio)/2
  else if tRatio < oRatio
    width = th*oRatio
    height = th
    left = (tw - th*oRatio)/2
    top = 0
  if margin is true
    if ext
      'width' : "#{width}#{ext}"
      'height' : "#{height}#{ext}"
      'margin-left' : "#{left}#{ext}"
      'margin-top' : "#{top}#{ext}"
    else
      'width' : width
      'height' : height
      'margin-left' : left
      'margin-top' : top
  else
    if ext
      width : "#{width}#{ext}"
      height : "#{height}#{ext}"
      left : "#{left}#{ext}"
      top : "#{top}#{ext}"
    else
      width : width
      height : height
      left : left
      top : top