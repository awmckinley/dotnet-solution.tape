require "require_relative"
require_relative "build/lib/paths"

def load_tasks
  Dir["PATHS[:rake_tasks]/**/*.rake"].sort.each { |ext| load(ext) }
end

load_tasks

task :default do
end

Albacore.configure do |config|
  config.assemblyinfo.namespaces = "System.Reflection"
  config.xunit.command = COMMANDS[:xunit]
end