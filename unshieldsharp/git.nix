{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "unshieldsharp";
  version = "3.1.0-unstable-2026-11-19";

  src = fetchFromGitHub {
    owner = "mnadareski";
    repo = "UnshieldSharp";
    rev = "32fdf8fa2631b80b0d9d0188802b643428a8b28e";
    hash = "sha256-jQ0CPlfl1k9NjirIctwGW9dd28J6j3fHRRUTKRkN/gA=";
  };

  buildType = "Debug";

  dotnet-sdk = dotnetCorePackages.sdk_11_0;
  dotnet-runtime = dotnetCorePackages.runtime_11_0;
  nugetDeps = ./deps-git.json;
  projectFile = "UnshieldSharp/UnshieldSharp.csproj";
  selfContainedBuild = false;
  dotnetFlags = [ "-p:TargetFrameworks=net11.0" ];
  dotnetBuildFlags = [ "--framework net11.0" ];
  dotnetInstallFlags = [ "--framework net11.0" ];

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
