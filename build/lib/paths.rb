COMMANDS = {
  :mspec                    => "tools/mspec/mspec-x86-clr4.exe",
  :nuget                    => "tools/nuget/NuGet.exe",
  :xunit                    => "tools/xunit/xunit.console.clr4.x86.exe",
}

PATHS = {
  :output                   => "build/artifacts",
  :rake_tasks               => "build/lib/tasks",

  :main => {
    :assembly               => "{{name}}.dll",
    :common_assembly_info   => "src/CommonAssemblyInfo.cs",
    :nuspec                 => "{{name}}.nuspec",
    :release_dir            => "src/{{name}}/bin/Release",
    :solution               => "src/{{name}}.sln",
    :specs => [
      # TODO Add specs project DLL paths here.
    ],
    :tests => [
      # TODO Add tests project DLL paths here.
    ],
  },
}