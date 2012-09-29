do ->
  _win = window
  _ob = _win
  
  _ob.DeviceRedirect = class DeviceRedirect
    constructor: (@platforms, @envRegEx, @ignoreList...) ->
  
    init: ->
      @currentLocation = window.location.href.toLowerCase()
      @isHere = if @currentLocation.match @envRegEx then true else false
  
      ismobile = (/iphone|ipod|android|blackberry|opera mini|opera mobi|windows phone|palm|iemobile/i.test(navigator.userAgent.toLowerCase()))
      istablet = (/ipad|tablet/i.test(navigator.userAgent.toLowerCase()))
      isdesktop = if ismobile or istablet then false else true
      @isThis =
        "mobile" : ismobile
        "tablet" : istablet
        "desktop" : isdesktop
  
      @shouldIgnore = false
                  
      if @ignoreList?
        for href in @ignoreList
          @shouldIgnore = true if @currentLocation.match href
      @
  
    go: ->
      if @currentLocation.match(/localhost/g) or @currentLocation.match(/localtunnel/g) or @currentLocation.match(/8888/g) or @shouldIgnore
        # console.log "Ignoring this location"
      else
        for platform, location of @platforms
          location = location.toLowerCase()
          notAlreadyThere = if @currentLocation.match(location) then false else true
          if @isThis["#{platform}"] and notAlreadyThere
            window.location = "http://#{location}"
      @
  
  t = setTimeout ->
    
    clearTimeout t
    
    localRedirect = new _ob.DeviceRedirect(
      mobile: "localhost:9999"
      tablet: "localhost:8888"
      desktop: "localhost:8888"
    , /localhost/g
    ).init()
    
    devRedirect = new _ob.DeviceRedirect(
      mobile: "m-dev-audi-performance.herokuapp.com/"
      tablet: "dev-audi-performance.herokuapp.com/"
      desktop: "dev-audi-performance.herokuapp.com/"
    , /dev/g
    ).init()
  
    reviewRedirect = new _ob.DeviceRedirect(
      mobile: "m-review-audi-performance.herokuapp.com/"
      tablet: "review-audi-performance.herokuapp.com/"
      desktop: "review-audi-performance.herokuapp.com/"
    , /review/g
    ).init()
  
    stagingCDNRedirect = new _ob.DeviceRedirect(
      mobile: "d3mlkbrqmw6be8.cloudfront.net"
      tablet: "d3ezcglqmjtk72.cloudfront.net"
      desktop: "d3ezcglqmjtk72.cloudfront.net"
    , /d3ezcglqmjtk72/g
    , "audi-performance-staging.s3-website-us-east-1.amazonaws.com"
    ).init()
  
    stagingRedirect = new _ob.DeviceRedirect(
      mobile: "m.staging.audiperformancecars.com"
      tablet: "staging.audiperformancecars.com"
      desktop: "staging.audiperformancecars.com"
    , /staging/g
    , "audi-performance-staging.s3-website-us-east-1.amazonaws.com"
    ).init()
  
    productionCDNRedirect = new _ob.DeviceRedirect(
      mobile: "dcu9a0sqxbuk3.cloudfront.net"
      tablet: "dxlvm5w9nv1u9.cloudfront.net"
      desktop: "dxlvm5w9nv1u9.cloudfront.net"
    , /dxlvm5w9nv1u9/g
    , "audi-performance.s3-website-us-east-1.amazonaws.com"
    ).init()
  
    productionRedirect = new _ob.DeviceRedirect(
      mobile: "m.audiperformancecars.com"
      tablet: "audiperformancecars.com"
      desktop: "audiperformancecars.com"
    , null
    , "audi-performance.s3-website-us-east-1.amazonaws.com"
    ).init()
    
    if localRedirect.isHere
      localRedirect.go()
    else if devRedirect.isHere
      devRedirect.go()
    else if reviewRedirect.isHere
      reviewRedirect.go()
    else if stagingCDNRedirect.isHere
      stagingCDNRedirect.go()
    else if stagingRedirect.isHere
      stagingRedirect.go()
    else if productionCDNRedirect.isHere
      productionCDNRedirect.go()
    else
      productionRedirect.go()
  
  , 500