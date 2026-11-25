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

  patches = [
    # Work around NU1510 being thrown.
    ./sabretools_workaround-NU1510.diff
  ];

  dotnet-sdk = dotnetCorePackages.sdk_11_0;
  dotnet-runtime = dotnetCorePackages.runtime_11_0;
  nugetDeps = ./deps-release.json;
  projectFile = "SabreTools/SabreTools.csproj";
  dotnetFlags = [ "-p:TargetFrameworks=net11.0" ];
  dotnetBuildFlags = [ "--framework net11.0" ];
  dotnetInstallFlags = [ "--framework net11.0" ];

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
