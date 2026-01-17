{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "binaryobjectscanner";
  version = "3.5.0-unstable-2026-01-10";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "BinaryObjectScanner";
    rev = "417c1f820824afc2f820a7baea806e437a4dc6b5";
    hash = "sha256-VQhw92a6YXoJOq5ec8NiaM05dqZB3VPmz+LWICyoCQw=";
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
