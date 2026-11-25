{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub,
}:

buildDotnetModule {
  pname = "sabretools-serialization";
  version = "3.3.0-unstable-2026-11-11";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools.Serialization";
    rev = "1cef79e6ff45c211ec821252d6a28f2d81c7df7a";
    hash = "sha256-saS9b8EQAK9s0wK6m6W7bQrJHXKcsKYdyijt/ru8rxg=";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  patches = [
    # Work around NU1510 being thrown.
    ./serialization_workaround-NU1510.diff
  ];

  dotnet-sdk = dotnetCorePackages.sdk_11_0;
  dotnet-runtime = dotnetCorePackages.runtime_11_0;
  nugetDeps = ./deps-git.json;
  projectFile = [ "ExtractionTool/ExtractionTool.csproj" "InfoPrint/InfoPrint.csproj" ];
  selfContainedBuild = false;
  dotnetFlags = [ "-p:TargetFrameworks=net11.0" ];
  dotnetBuildFlags = [ "--framework net11.0" ];
  dotnetInstallFlags = [ "--framework net11.0" ];

  executables = [ "ExtractionTool" "InfoPrint" ];

  # "sts_" in final filenames is short for "Sabretools.Serialization"
  # Mainly to avoid collisions with possible other tools.
  preFixup = ''
    mv $out/bin/ExtractionTool $out/bin/sts_extractiontool
    mv $out/bin/InfoPrint $out/bin/sts_infoprint
  '';

  meta = {
    description = "";
    homepage = "https://github.com/SabreTools/SabreTools.Serialization";
    license = lib.licenses.mit;
      # Confirmed via "SabreTools.Serialization/SabreTools.Serialization.csproj"
      # Also confirmed with dev that it's MIT licensed.
    maintainers = with lib.maintainers; [ ];
    mainProgram = "sts_infoprint";
    platforms = lib.platforms.all;
  };
}
