{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule rec {
  pname = "unshieldsharp";
  version = "2.1.0";

  src = fetchFromGitHub {
    owner = "mnadareski";
    repo = "UnshieldSharp";
    tag = "${version}";
    hash = "sha256-Aw2JlI6/cVuBx2G3ZoGJr00NwL1waUvxDU//OPwnuEs=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.runtime_10_0;
  nugetDeps = ./deps-release.json;
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
