#!/usr/bin/env ruby
require 'yaml'

@ROOT = File.expand_path "."

@yml = YAML::load( File.open( "#{@ROOT}/data/config.yaml" ) )

@ENV_DEVELOPMENT = "development"
@ENV_REVIEW = "review"
@ENV_STAGING = "staging"
@ENV_PRODUCTION = "production"

def require_tasks ( folder_path )
  Dir.glob( "#{@ROOT}/lib/tasks#{folder_path}/*.rb" ) { |file| require file }
end

require_tasks '/core'
require_tasks '/project'
