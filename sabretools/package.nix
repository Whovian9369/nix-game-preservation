{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages
}:

buildDotnetModule rec {
  pname = "sabretools";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools";
    tag = "${version}";
    hash = "sha256-2/Lh0/9fFVmo4rex8Stai044mpdWVP+ntXWX+/9eNIA=";
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
