require "require_relative"
require "albacore"
require "version_bumper"
require "rake/clean"
require_relative "../paths"
require_relative "../projects_info"

desc "Generates the common assembly info."
task :prepare => ["main:assembly_info"]

desc "Build the project and run the tests."
task :build => ["main:build"]

desc "Build the project without running the tests."
task :build_skip_test => ["main:build_skip_test"]

namespace :main do

  task :build => [:assembly_info, :msbuild, :test]
  task :build_skip_test => [:assembly_info, :msbuild]
  task :test => [:msbuild, :xunit]

  assemblyinfo :assembly_info do |asm|
    asm.version = bumper_version.to_s
    asm.file_version = bumper_version.to_s

    asm.product_name = PROJECTS[:main][:product]
    asm.company_name = PROJECTS[:main][:company]
    asm.copyright = PROJECTS[:main][:copyright]

    asm.output_file = PATHS[:main][:common_assembly_info]
  end

  msbuild :msbuild do |msb, args|
    msb.properties = { :Configuration => :Release }
    msb.targets :Clean, :Build
    msb.solution = PATHS[:main][:solution]
  end

  xunit :xunit do |xunit|
    xunit.assemblies PATHS[:main][:tests]
  end

end

CLOBBER.include("src/*/*/bin")
CLOBBER.include("src/*/*/obj")