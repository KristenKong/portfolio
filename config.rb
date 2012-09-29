require 'yaml'
require 'middleman-smusher'

###
# Helpers
###

$ENV_DEVELOPMENT = 'development'
$ENV_REVIEW = 'review'
$ENV_STAGING = 'staging'
$ENV_PRODUCTION = 'production'

$env = ENV['ENVIRONMENT'] || $ENV_DEVELOPMENT

class Config
  @@version = YAML::load( File.open( 'data/version.yaml' ) )
  @@build_version = @@version[ 'build_version' ]
  @@cache_buster = "?#{@@build_version}"
  @@debug_flag = ( $env === $ENV_PRODUCTION ) ? false : true
  
  def self.environment_type
    $env
  end
  def self.build_version
    @@build_version || 'v0'
  end
  def self.cache_buster
    @@cache_buster
  end
  def self.debug_flag
    @@debug_flag
  end
end

helpers do
  def image_tag_cb(file_name, options = {})
    image_tag "#{file_name}#{Config.cache_buster}", options
  end
  def environment_type
    Config.environment_type
  end
  def build_version
    Config.build_version
  end
  def cache_buster
    Config.cache_buster
  end
  def debug_flag
    Config.debug_flag
  end
  def get_site_url
    "#{data.config.site.protocol}://#{data.config.environments[$env].urls.desktop}"
  end
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'
set :build_dir, 'build'

# TODO: [RKP] : Maybe get this to work???
# puts '------------------------------'
# if !!ENV['HOME'] === true and !!ENV['HEROKU'] === false
  # puts 'Build is running in local middleman env.'
  # set :build_dir, "build/public"
# else
  # puts 'Build is running in remote hosted env.'
  # set :build_dir, "tmp"
# end
# puts '------------------------------'

###
# Features
###

module Middleman::Features::ProjectJS
  class << self
    def registered(app)
      app.compass_config do |config|
        config.fonts_dir = :fonts_dir
      end
    end
    alias :included :registered
  end
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
  activate :cache_buster
  # TODO : [RKP] : Smusher fails if too many images on Heroku
  # activate :smusher
  # activate :gzip
  # activate :asset_hash
end