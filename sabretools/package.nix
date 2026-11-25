{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages
}:

buildDotnetModule (finalAttrs: {
  pname = "sabretools";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools";
    tag = finalAttrs.version;
    hash = "sha256-XOD4Zf6nwZfmjtBZ2Nfj45pYBrpKLtTVcdkNuuKxET8=";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.runtime_10_0;
  nugetDeps = ./deps-release.json;
  projectFile = "SabreTools/SabreTools.csproj";
  dotnetFlags = [ "-p:TargetFrameworks=net10.0" ];
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
})
