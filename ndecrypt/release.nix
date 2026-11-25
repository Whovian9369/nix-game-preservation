{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule rec {
  pname = "ndecrypt";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "NDecrypt";
    tag = "${version}";
    hash = "sha256-TIrtCEZPgEJoFv47Lpyp4gKF+JSc8F/QI4UEowUvUP0=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_11_0;
  dotnet-runtime = dotnetCorePackages.runtime_11_0;
  nugetDeps = ./deps-release.json;
  projectFile = "NDecrypt/NDecrypt.csproj";
  selfContainedBuild = false;
  dotnetFlags = [ "-p:TargetFrameworks=net11.0" ];
  dotnetBuildFlags = [ "--framework net11.0" ];
  dotnetInstallFlags = [ "--framework net11.0" ];

  executables = [ "ndecrypt" ];

  postInstall = ''
    mv $out/lib/ndecrypt/NDecrypt $out/lib/ndecrypt/ndecrypt
  '';

  meta = {
    description = "Cartridge encrypt/decrypt";
    homepage = "https://github.com/SabreTools/NDecrypt";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "ndecrypt";
    platforms = lib.platforms.all;
  };
}
