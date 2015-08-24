#!/usr/bin/env rake

task :app do
  require "./app"
end

# require all tasks from lib/tasks/
Dir[File.dirname(__FILE__) + "/lib/tasks/*.rb"].sort.each do |path|
  require path
end
