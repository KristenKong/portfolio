_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ "Helpers", "Google" ]

_log = _NS.log "Google"


_googleApiKey = undefined

_ob.setApiKey = (googleApiKey) -> 
  _log "setApiKey : #{googleApiKey}"
  _googleApiKey = googleApiKey

_ob.shortenUrl = (longUrl, callback) ->
    
    _log "shortenUrl : #{longUrl}"
    
    url = "https://www.googleapis.com/urlshortener/v1/url?key=#{_googleApiKey}"
    
    request = 
      url : url
      type : 'POST'
      dataType: 'json'
      contentType : 'application/json; charset=UTF-8'
      data : JSON.stringify { 'longUrl' : longUrl }
      
      success : (jqxhr) =>
        
        shortUrl = jqxhr.id
        
        # _log 'Short Url : ', shortUrl
        
        callback shortUrl
        
      error : (jqxhr) =>
        
        _log '[ !!! Error !!! ]', 'Shortened Url Unavailable', jqxhr
        
    $.ajax request
    
    @
    

# _ob.Bitly = 
  # clientId : undefined
  # clientSecret : undefined
  # accessToken : undefined
# 
# _shortenUrl = (longUrl, calback) ->
#   
  # request = 
    # url : 'https://api-ssl.bitly.com/oauth/access_token'
    # type : 'GET'
    # data :
      # longUrl : escape longUrl
      # access_token : accessToken
#     
    # success : (jqxhr) =>
#       
      # shortUrl = jqxhr.data.url
#       
      # _log 'Url Shortened', jqxhr
#       
      # callback shortUrl
#       
    # error : (jqxhr) =>
#       
      # _log '[ !!! Error !!! ]', 'Shortened Url Unavailable'
#       
#       
  # $.ajax request
#   
  # @
#   
# _getToken = (calback) ->
#   
  # request = 
    # url : 'https://api-ssl.bitly.com/oauth/access_token'
    # type : 'POST'
    # data :
      # client_id : _ob.clientId
      # client_secret : _ob.clientSecret
#     
    # success : (jqxhr) =>
#       
      # _log 'Access Token', jqxhr
      # # _ob.accessToken = jqxhr.
#       
      # callback()
#       
    # error : (jqxhr) =>
#       
      # _log '[ !!! Error !!! ]', 'Access Token Unavailable'
#       
#       
  # $.ajax request
#   
# 
# _ob.bitly = (longUrl, callback) ->
  # _log 'Bit.ly'
#   
  # if _ob.token
    # _shortenUrl longUrl, (shortUrl) => callback shortUrl
  # else
    # _getToken => _shortenUrl longUrl, (shortUrl) => callback shortUrl
#   
  # @
  
