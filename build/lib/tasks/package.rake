require "rubygems"
require "bundler/setup"
require "require_relative"
require "albacore"
require "semver"
require "rake/clean"
require_relative "../paths"
require_relative "../projects_info"

desc "Package project for NuGet."
task :package => [:build, :nuspec, :nugetpack]

desc "Generates the NuSpec file."
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

  nuspec.working_directory = PATHS[:output]
  nuspec.output_file = PATHS[:main][:nuspec]
  nuspec.file "lib\\net40\\*.dll", "lib\\net40"
end

desc "Builds the NuGet package."
nugetpack :nugetpack do |nuget|
  nuget.command = COMMANDS[:nuget]
  nuget.nuspec = File.join(PATHS[:output], PATHS[:main][:nuspec])
  nuget.base_folder = PATHS[:output]
  nuget.output = PATHS[:output]
end
