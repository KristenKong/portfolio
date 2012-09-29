#!/usr/bin/env ruby
namespace :browser do
  desc "Browser : Open Chrome"
  task :chrome do
    sh %{open /Applications/Google\ Chrome.app #{LOCALHOST}#{port_mm}}
  end
  
  desc "Browser : Open FF"
  task :ff do
    sh %{open -a Firefox #{LOCALHOST}#{port_mm}}
  end
  
  desc "Browser : Open Safari"
  task :safari do
    sh %{open -a Safari #{LOCALHOST}#{port_mm}}
  end
end