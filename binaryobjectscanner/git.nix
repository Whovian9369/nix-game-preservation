{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "binaryobjectscanner";
  version = "3.10.0-unstable-2026-11-22";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "BinaryObjectScanner";
    rev = "dd86cd813de5302adf95d7b14f1545ad5d4bbe99";
    hash = "sha256-p+qWC1jbE3AFnHfK3qvDLXaSjyVXVqTx8N5O1hroAuw=";
    fetchSubmodules = true;
    leaveDotGit = false;
  };

  patches = [
    # Work around NU1510 being thrown.
    ./binaryobjectscanner_workaround-NU1510.diff
  ];

  dotnet-sdk = dotnetCorePackages.sdk_11_0;
  dotnet-runtime = dotnetCorePackages.runtime_11_0;
  nugetDeps = ./deps.json;
  projectFile = [ "ProtectionScan/ProtectionScan.csproj" ];
  selfContainedBuild = false;
  dotnetFlags = [ "-p:TargetFrameworks=net11.0" ];
  dotnetBuildFlags = [ "--framework net11.0" ];
  dotnetInstallFlags = [ "--framework net11.0" ];

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
