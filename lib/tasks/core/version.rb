#!/usr/bin/env ruby

BUILD_VERSION_PREFIX = "v"
VERSION_FILENAME = "#{@ROOT}/data/version.yaml"

namespace :version do
  
  desc "Version : Increment"
  task :increment do
    increment_build_version()
  end
  
  desc "Version : Tag"
  task :tag do
    tag_build()
  end
  
end

def increment_build_version
  version_key = 'build_version'
  version_val = "0"
  prefix = 'v'
  filename = VERSION_FILENAME
  # Check for version.yml
  if ( File.exists? filename ) === false
    # If no file, create
    f = File.new filename, 'w'
    puts f
    f.write "#{version_key} : #{BUILD_VERSION_PREFIX}#{version_val}"
    f.close()
  end
  # Open version.yml
  f = File.open filename, 'r+'
  # Load YAML
  yml = YAML::load( f )
  # Check for key/val
  yml.each_pair do |key, val|
    # Read 'version_key'
    if key === version_key
      # Parse out number, iterate +1
      puts "Previous Build Version : #{val}"
      version_val = "#{( ( val.split prefix )[ 1 ].to_i ) + 1}"
    end
  end
  # Delete old/default file
  File.delete filename
  # Alias version Id
  id_s = "#{BUILD_VERSION_PREFIX}#{version_val}"
  puts "Updated Build Version : #{id_s}"
  # Create a new file
  f = File.new filename, 'w'
  s = "#{version_key} : #{id_s}"
  f.write( s )
  f.close()
end

def tag_build ()
  puts "Updating tags in git"
  
  filename = VERSION_FILENAME
  version_key = 'build_version_id'
  version_val = "v0"
  # Open version.yml
  f = File.open filename, 'r+'
  # Load YAML
  yml = YAML::load( f )
  # Check for key/val
  yml.each_pair do |key, val|
    puts "#{key} = #{val}"
    # Read 'version_key'
    if key === version_key
      version_val = val.to_s
    end
  end
  
  f.close()
  
  begin
    sh %{git add -A}
    sh %{git commit -m "Build version #{version_val}"}
    sh %{git tag -a #{version_val} -m "Build version #{version_val}"}
  rescue Exception => e
    puts "!!! Something went worng !!!"
    puts e
  ensure
    sh %{git tag -l -n}
    sh %{git status}
  end
end
