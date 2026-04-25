{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages
}:

buildDotnetModule {
  pname = "sabretools";
  version = "1.2.1-unstable-2026-04-24";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools";
    rev = "3100250c0d00b586c72c553fe6bdbb1795fc63da";
    hash = "sha256-knDeoyQ7Y9VLJjKBkMsJrBP8DL1Y/aXiFAONDIVYjrs=";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.runtime_10_0;
  nugetDeps = ./deps-git.json;
  projectFile = "SabreTools/SabreTools.csproj";
  dotnetBuildFlags = [ "--framework net10.0" ];
  dotnetInstallFlags = [ "--framework net10.0" ];

  executables = [ "SabreTools" ];

  postFixup = ''
    mv $out/bin/SabreTools $out/bin/sabretools
  '';

  meta = {
    description = "DAT management tool with advanced editing and sorting features";
    homepage = "https://github.com/SabreTools/SabreTools";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "sabretools";
    platforms = lib.platforms.all;
  };
}
