{ lib,
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
    rev = "acfd6b1d116fc9d0d75166654df92fd1b0fb455d";
    hash = "sha256-/bH+LV7tEdXcbP52j9hH0MU0V+oGWoJlZMla5Bq72fg=";
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
