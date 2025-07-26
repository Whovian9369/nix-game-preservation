{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "unshieldsharp";
  version = "1.9.4";

  src = fetchFromGitHub {
    owner = "mnadareski";
    repo = "UnshieldSharp";
    rev = "6aa463f11c67e676bf75e04565ba97dc7e165dc9";
    hash = "sha256-MY4noY8t+63W0mURvz9Yh7xh6YF7+doh0pTaCjchuNY=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-git.json;
  projectFile = "Test/Test.csproj";
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net9.0" ];
  dotnetInstallFlags = [ "--framework net9.0" ];

  executables = [ "Test" ];

  preFixup = ''
    mv $out/bin/Test $out/bin/unshieldsharp
  '';

  meta = {
    description = "Port of Unshield to C";
    homepage = "https://github.com/mnadareski/UnshieldSharp";
    license = with lib.licenses; [ mit asl20 ];
    maintainers = with lib.maintainers; [ ];
    mainProgram = "unshieldsharp";
    platforms = lib.platforms.all;
  };
}
