require 'rubygems'
require 'bundler/setup'
require 'require_relative'
require 'fileutils'
require 'albacore'
require 'semver'
require 'rake/clean'
require_relative '../paths'
require_relative '../projects_info'

desc 'Package project for NuGet.'
task :package => [:build, :readme, :nuspec, :nugetpack]

desc 'Prepare README and LICENSE for Nuget.'
task :readme do
  FileUtils.mkdir_p PATHS[:output]
  FileUtils.cp './README.md', File.join(PATHS[:output], 'README.md')
  FileUtils.cp './LICENSE', File.join(PATHS[:output], 'LICENSE')
end

desc 'Generates the NuSpec file.'
nuspec :nuspec do |nuspec|
  nuspec.id = PROJECTS[:main][:nuget_id]
  nuspec.version = SemVer.find.format "%M.%m.%p%s"
  nuspec.title = PROJECTS[:main][:product]
  nuspec.authors = PROJECTS[:main][:authors]
  nuspec.description = PROJECTS[:main][:description]
  nuspec.summary = PROJECTS[:main][:summary]
  nuspec.language = "en-US"
  nuspec.projectUrl = PROJECTS[:main][:url]
  nuspec.licenseUrl = PROJECTS[:main][:license_url]
  nuspec.copyright = PROJECTS[:main][:copyright]
  nuspec.requireLicenseAcceptance = "false"
  nuspec.tags = PROJECTS[:main][:tags]

  PROJECTS[:main][:dependencies].each {|id, version| nuspec.dependency id, version}

  nuspec.working_directory = PATHS[:output]
  nuspec.output_file = PATHS[:main][:nuspec]
  nuspec.file "lib\\net40\\*.dll", "lib\\net40"
  nuspec.file 'README.md'
  nuspec.file 'LICENSE'
end

desc 'Builds the NuGet package.'
nugetpack :nugetpack do |nuget|
  nuget.command = COMMANDS[:nuget]
  nuget.nuspec = File.join(PATHS[:output], PATHS[:main][:nuspec])
  nuget.base_folder = PATHS[:output]
  nuget.output = PATHS[:output]
end
