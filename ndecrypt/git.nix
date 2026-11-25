{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "ndecrypt";
  version = "0.7.0-unstable-2026-11-19";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "NDecrypt";
    rev = "acb1b7c51f8a1806349a5a469c1a43c9f967415a";
    hash = "sha256-gpayzjAP3szwAap+2sNYVG8e2IZPhvLf4GWwpQ3Zj2E=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_11_0;
  dotnet-runtime = dotnetCorePackages.runtime_11_0;
  nugetDeps = ./deps-git.json;
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
