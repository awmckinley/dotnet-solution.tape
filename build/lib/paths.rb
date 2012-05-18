COMMANDS = {
  :nuget                    => "tools/nuget/NuGet.exe",
  :xunit                    => "tools/xunit/xunit.console.clr4.x86.exe",
}

PATHS = {
  :rake_tasks               => "build/lib/tasks",

  :main => {
    :common_assembly_info   => "src/CommonAssemblyInfo.cs",
    :solution               => "src/{{name}}.sln",
    :tests => [
      # TODO Add test project DLL paths here.
    ],
  },
}