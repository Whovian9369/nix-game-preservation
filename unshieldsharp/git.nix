{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "unshieldsharp";
  version = "2.0.0-unstable-2026-03-15";

  src = fetchFromGitHub {
    owner = "mnadareski";
    repo = "UnshieldSharp";
    rev = "131383560b2824780bfa1d7278166b193445576f";
    hash = "sha256-VLXNPvI4+RAs1Pz+VJ+BOGRKQZBkfZzoXBBQqd4u+ew=";
  };

  buildType = "Debug";

  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.runtime_10_0;
  nugetDeps = ./deps-git.json;
  projectFile = "UnshieldSharp/UnshieldSharp.csproj";
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net10.0" ];
  dotnetInstallFlags = [ "--framework net10.0" ];

  executables = [ "UnshieldSharp" ];

  preFixup = ''
    mv $out/bin/UnshieldSharp $out/bin/unshieldsharp
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
