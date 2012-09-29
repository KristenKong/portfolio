#!/usr/bin/env ruby

@defaults = @yml["defaults"]

namespace :mm do
  
  desc "Middleman : Start Local Server"
  task :s, [:port] do |t, args|
    port = args.port || @defaults["port"]
    ENV['ENVIRONMENT'] = @ENV_DEVELOPMENT
    sh %{middleman server -p #{port}}
  end
  
  # Build Tasks
  namespace :build do
    
    desc "Middleman : Build : DEVELOPMENT"
    task :dev do
      build @ENV_DEVELOPMENT, false, false
    end
    
    desc "Middleman : Build : REVIEW"
    task :review do
      build @ENV_REVIEW, false, true
    end
    
    desc "Middleman : Build : STAGING"
    task :staging do
      build @ENV_STAGING, true, false
    end
    
    desc "Middleman : Build : PRODUCTION"
    task :production do
      build @ENV_PRODUCTION, true, true
    end
    
  end
  
end

def build(env, increment, tag)
  
  if increment === true
    Rake::Task["version:increment"].invoke
  end
  
  if tag === true
    Rake::Task["version:tag"].invoke
  end
  
  ENV['ENVIRONMENT'] = env
  sh %{middleman build -c}
    
end