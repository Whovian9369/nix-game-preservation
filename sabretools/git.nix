{
  lib,
  buildDotnetModule,
  fetchFromGitHub,
  dotnetCorePackages
}:

buildDotnetModule {
  pname = "sabretools";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "SabreTools";
    rev = "61e14883494ea406015ecf67d3c9cb955d0536bf";
    hash = "sha256-tNbEgq5n2SgRDrQS/WQhvUaA6ruav8THLtXXa7I7QEU=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-git.json;
  projectFile = "SabreTools/SabreTools.csproj";
  dotnetBuildFlags = [ "--framework net9.0" ];
  dotnetInstallFlags = [ "--framework net9.0" ];

  meta = with lib; {
    description = "DAT management tool with advanced editing and sorting features";
    homepage = "https://github.com/SabreTools/SabreTools";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "SabreTools";
    platforms = platforms.all;
  };
}
