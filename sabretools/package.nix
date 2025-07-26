{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages
}:

buildDotnetModule rec {
  pname = "sabretools";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools";
    tag = "${version}";
    hash = "sha256-7zNdZZcTD1Zk0V5UYiSgOjBExHsW1wh64TQrCwkzvyk=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-release.json;
  projectFile = "SabreTools/SabreTools.csproj";
  dotnetBuildFlags = [ "--framework net5.0" ];
  dotnetInstallFlags = [ "--framework net5.0" ];

  meta = with lib; {
    description = "DAT management tool with advanced editing and sorting features";
    homepage = "https://github.com/SabreTools/SabreTools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "SabreTools";
    platforms = platforms.all;
  };
}
