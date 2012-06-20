require 'rubygems'
require 'bundler/setup'
require 'require_relative'
require 'albacore'
require_relative 'build/lib/paths'

def load_tasks
  Dir["#{PATHS[:rake_tasks]}/**/*.rake"].sort.each { |ext| load(ext) }
end

load_tasks

task :default do
end

Albacore.configure do |config|
  config.log_level = :verbose
  config.assemblyinfo.namespaces = ['System.Reflection']
  config.mspec.command = COMMANDS[:mspec]
  config.xunit.command = COMMANDS[:xunit]
end