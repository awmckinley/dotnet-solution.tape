require 'rubygems'
require 'bundler/setup'
require 'require_relative'
require 'fileutils'
require 'albacore'
require 'semver'
require 'rake/clean'
require_relative '../paths'
require_relative '../projects_info'

desc 'Generates the common assembly info.'
task :prepare => ['main:assembly_info']

desc 'Build the project and run the tests.'
task :build => ['main:build']

desc 'Build the project without running the tests.'
task :build_skip_test => ['main:build_skip_test']

namespace :main do

  task :build => [:assembly_info, :msbuild, :test, :merge]
  task :build_skip_test => [:assembly_info, :msbuild, :merge]
  task :test => [:msbuild, :xunit, :mspec]

  assemblyinfo :assembly_info do |asm|
    v = SemVer.find
    asm.version = v.format '%M.%m.%p'
    asm.file_version = v.format '%M.%m.%p'

    asm.product_name = PROJECTS[:main][:product]
    asm.company_name = PROJECTS[:main][:company]
    asm.copyright = PROJECTS[:main][:copyright]

    asm.custom_attributes({
      :AssemblyInformationalVersion => v.format('%M.%m.%p%s')
    })

    asm.output_file = PATHS[:main][:common_assembly_info]
  end

  msbuild :msbuild do |msb, args|
    msb.properties = { :Configuration => :Release }
    msb.targets :Clean, :Build
    msb.solution = PATHS[:main][:solution]
  end

  exec :merge do |cmd|
    out_dir = File.join(PATHS[:output], 'lib', 'net40')
    FileUtils.mkdir_p out_dir

    lib = Dir['packages/**/*.dll'].collect {|path| "/lib:#{File.dirname(path)}"}
    out = File.join(out_dir, PATHS[:main][:assembly])
    primary = File.join(PATHS[:main][:release_dir], PATHS[:main][:assembly])

    cmd.command = 'ilmerge'
    cmd.parameters.concat lib
    cmd.parameters.concat ['/internalize', '/t:library', '/v4', "/out:#{out}", primary]
    cmd.parameters.concat PATHS[:main][:merge]
  end

  xunit :xunit do |xunit|
    xunit.assemblies PATHS[:main][:tests]
  end

  mspec :mspec do |mspec|
    mspec.assemblies PATHS[:main][:specs]
  end

end

CLOBBER.include("src/**/bin")
CLOBBER.include("src/**/obj")
CLOBBER.include(PATHS[:output])
