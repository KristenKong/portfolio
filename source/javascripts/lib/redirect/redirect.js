(function() {
  var DeviceRedirect, t, _ob, _win, __slice;
  __slice = [].slice;
  _win = window;
  _ob = _win;
  _ob.DeviceRedirect = DeviceRedirect = (function() {

    function DeviceRedirect() {
      var envRegEx, ignoreList, platforms;
      platforms = arguments[0], envRegEx = arguments[1], ignoreList = 3 <= arguments.length ? __slice.call(arguments, 2) : [];
      this.platforms = platforms;
      this.envRegEx = envRegEx;
      this.ignoreList = ignoreList;
    }

    DeviceRedirect.prototype.init = function() {
      var href, isdesktop, ismobile, istablet, _i, _len, _ref;
      this.currentLocation = window.location.href.toLowerCase();
      this.isHere = this.currentLocation.match(this.envRegEx) ? true : false;
      ismobile = /iphone|ipod|android|blackberry|opera mini|opera mobi|windows phone|palm|iemobile/i.test(navigator.userAgent.toLowerCase());
      istablet = /ipad|tablet/i.test(navigator.userAgent.toLowerCase());
      isdesktop = ismobile || istablet ? false : true;
      this.isThis = {
        "mobile": ismobile,
        "tablet": istablet,
        "desktop": isdesktop
      };
      this.shouldIgnore = false;
      if (this.ignoreList != null) {
        _ref = this.ignoreList;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          href = _ref[_i];
          if (this.currentLocation.match(href)) {
            this.shouldIgnore = true;
          }
        }
      }
      return this;
    };

    DeviceRedirect.prototype.go = function() {
      var location, notAlreadyThere, platform, _ref;
      if (this.currentLocation.match(/localhost/g) || this.currentLocation.match(/localtunnel/g) || this.currentLocation.match(/8888/g) || this.shouldIgnore) {

      } else {
        _ref = this.platforms;
        for (platform in _ref) {
          location = _ref[platform];
          location = location.toLowerCase();
          notAlreadyThere = this.currentLocation.match(location) ? false : true;
          if (this.isThis["" + platform] && notAlreadyThere) {
            window.location = "http://" + location;
          }
        }
      }
      return this;
    };

    return DeviceRedirect;

  })();
  return t = setTimeout(function() {
    var devRedirect, localRedirect, productionCDNRedirect, productionRedirect, reviewRedirect, stagingCDNRedirect, stagingRedirect;
    clearTimeout(t);
    localRedirect = new _ob.DeviceRedirect({
      mobile: "localhost:9999",
      tablet: "localhost:8888",
      desktop: "localhost:8888"
    }, /localhost/g).init();
    devRedirect = new _ob.DeviceRedirect({
      mobile: "m-dev-audi-performance.herokuapp.com/",
      tablet: "dev-audi-performance.herokuapp.com/",
      desktop: "dev-audi-performance.herokuapp.com/"
    }, /dev/g).init();
    reviewRedirect = new _ob.DeviceRedirect({
      mobile: "m-review-audi-performance.herokuapp.com/",
      tablet: "review-audi-performance.herokuapp.com/",
      desktop: "review-audi-performance.herokuapp.com/"
    }, /review/g).init();
    stagingCDNRedirect = new _ob.DeviceRedirect({
      mobile: "d3mlkbrqmw6be8.cloudfront.net",
      tablet: "d3ezcglqmjtk72.cloudfront.net",
      desktop: "d3ezcglqmjtk72.cloudfront.net"
    }, /d3ezcglqmjtk72/g, "audi-performance-staging.s3-website-us-east-1.amazonaws.com").init();
    stagingRedirect = new _ob.DeviceRedirect({
      mobile: "m.staging.audiperformancecars.com",
      tablet: "staging.audiperformancecars.com",
      desktop: "staging.audiperformancecars.com"
    }, /staging/g, "audi-performance-staging.s3-website-us-east-1.amazonaws.com").init();
    productionCDNRedirect = new _ob.DeviceRedirect({
      mobile: "dcu9a0sqxbuk3.cloudfront.net",
      tablet: "dxlvm5w9nv1u9.cloudfront.net",
      desktop: "dxlvm5w9nv1u9.cloudfront.net"
    }, /dxlvm5w9nv1u9/g, "audi-performance.s3-website-us-east-1.amazonaws.com").init();
    productionRedirect = new _ob.DeviceRedirect({
      mobile: "m.audiperformancecars.com",
      tablet: "audiperformancecars.com",
      desktop: "audiperformancecars.com"
    }, null, "audi-performance.s3-website-us-east-1.amazonaws.com").init();
    if (localRedirect.isHere) {
      return localRedirect.go();
    } else if (devRedirect.isHere) {
      return devRedirect.go();
    } else if (reviewRedirect.isHere) {
      return reviewRedirect.go();
    } else if (stagingCDNRedirect.isHere) {
      return stagingCDNRedirect.go();
    } else if (stagingRedirect.isHere) {
      return stagingRedirect.go();
    } else if (productionCDNRedirect.isHere) {
      return productionCDNRedirect.go();
    } else {
      return productionRedirect.go();
    }
  }, 500);
})();