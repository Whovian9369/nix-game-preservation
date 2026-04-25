{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "binaryobjectscanner";
  version = "3.6.0-unstable-2026-03-26";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "BinaryObjectScanner";
    rev = "759e4bead02dae572d46d489545a49f91300b876";
    hash = "sha256-zHaXc6envnorAMazz/2CmxCytP/112Vv0UI4sqAKbLk=";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.runtime_10_0;
  nugetDeps = ./deps.json;
  projectFile = [ "ProtectionScan/ProtectionScan.csproj" ];
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net10.0" ];
  dotnetInstallFlags = [ "--framework net10.0" ];

  executables = [ "ProtectionScan" ];

  preFixup = ''
    mv $out/bin/ProtectionScan $out/bin/bos-protectionscan
  '';

  meta = {
    description = "C# protection, packer, and archive scanning library";
    homepage = "https://github.com/SabreTools/BinaryObjectScanner";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "bos-protectionscan";
    platforms = lib.platforms.all;
  };
}
