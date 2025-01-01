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
    rev = "4df063443b9b674e8bd4987b7cc8df26fdfa4708";
    hash = "sha256-eBXA4He1G5IO4pXQh6rHsXkveueI4xWoWDJgu6mjMfw=";
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
