{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub,
}:

buildDotnetModule rec {
  pname = "sabretools-serialization";
  version = "2.2.1-unstable-2025-12-04";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools.Serialization";
    rev = "d7131dfa4c71dd15d7e5f8226f93e7132ac5c519";
    hash = "sha256-jhroKKdPWlYXETrpqc/UBkS4/XwnuXD9Ba0wB8yx9nI=";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.runtime_10_0;
  nugetDeps = ./deps-git.json;
  projectFile = [ "ExtractionTool/ExtractionTool.csproj" "InfoPrint/InfoPrint.csproj" ];
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net10.0" ];
  dotnetInstallFlags = [ "--framework net10.0" ];

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
