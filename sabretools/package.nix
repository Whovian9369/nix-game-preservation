{ lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages
}:

buildDotnetModule {
  pname = "sabretools";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools";
    rev = "c10b65dfcc5ef9a089c14247bcf740657556ef83";
    hash = "sha256-ZdTvmc01amo0WS0FV/6p+qvuCFqQZPkMt4Ieq1E4PJ4=";
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
