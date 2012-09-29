_NS = @__get_project_namespace__()
_NS.DataLoader ?= {}

_errorString = "[!!! Error !!!]"

_log = _NS.log "DataLoader"

_ob = _NS.DataLoader
_retries = 2
_timeout = 1000 * 2

_ob.getJSON = (url, success, error = undefined, cache = true, retry = 0) =>
  
  _load 'json', url, success, error, cache, retry
  
  @

_ob.getJSONP = (url, success, error = undefined, cache = false, retry = 0) =>
  
  _load 'jsonp', url, success, error, cache, retry
  
  @
  
_load = (dataType, url, success, error = undefined, cache = false, retry = 0) =>
      
  request = 
    url : url
    dataType : dataType
    cache : cache
    timeout : _timeout
    
    success : (jqxhr) =>
      
      success jqxhr, url
      
    error : (jqxhr) =>
      
      @log " "
      @log "[ !!! Error Begin"
      @log " "
      @log "Code: '#{jqxhr.status}'"
      @log "Message: '#{jqxhr.statusText}'"
      @log "Request: '#{url}'"
      
      if retry++ < _retries
        
        @log " "
        @log ">>> Retry #{retry} of #{_retries}"
        
        _load dataType, url, success, error, cache, retry
      else
        if error isnt undefined
          @log " "
          @log ">>> Handling..."
          error? jqxhr, url
        else
          @log " "
          @log ">>> Not Handeling..."

      @log " "
      @log "!!! Error End ]"
      @log " "
      
      
    statusCode :
      400 : => @log "#{_errorString} Request: '#{url}' is a bad request."
      403 : => @log "#{_errorString} Request: '#{url}' was not found."
      404 : => @log "#{_errorString} Request: '#{url}' is forbidden."
      0 : => @log "#{_errorString} Request: '#{url}' has timed out."
      
  $.ajax request
  
  @
  
  
