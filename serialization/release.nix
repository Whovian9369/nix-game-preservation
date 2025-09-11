{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub,
}:

buildDotnetModule rec {
  pname = "sabretools-serialization";
  version = "1.9.1";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools.Serialization";
    rev = version;
    hash = "sha256-459GU/ML/JerKgHPwoRsuWf51Y1tO26Pbhe2ohDgasI=";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-release.json;
  projectFile = [ "ExtractionTool/ExtractionTool.csproj" "InfoPrint/InfoPrint.csproj" ];
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net9.0" ];
  dotnetInstallFlags = [ "--framework net9.0" ];

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
