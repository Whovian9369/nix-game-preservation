{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule rec {
  pname = "unshieldsharp";
  version = "v2.0.0";

  src = fetchFromGitHub {
    owner = "mnadareski";
    repo = "UnshieldSharp";
    tag = "v${version}";
    hash = "sha256-5SR1FmAo+OCPeTm58NdYOexj4/+rdszb/mQ+5ijkbQg=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-release.json;
  projectFile = "UnshieldSharp/UnshieldSharp.csproj";
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net9.0" ];
  dotnetInstallFlags = [ "--framework net9.0" ];

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
