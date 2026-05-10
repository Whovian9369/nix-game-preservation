{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages
}:

buildDotnetModule {
  pname = "sabretools";
  version = "1.2.1-unstable-2026-04-28";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools";
    rev = "ad66e1f95f34139dd470609e4a94a15107b0a633";
    hash = "sha256-RnMG+boQpUKb0y7E2J44MPSORWGsaJOdGu1EIGFqACw=";
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
