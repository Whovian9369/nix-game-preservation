{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule rec {
  pname = "ndecrypt";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "NDecrypt";
    tag = "${version}";
    hash = "sha256-o7dCIJk9EaS5KdymfQ7jP6uAA/DrwBilzbGVTjXMTn0=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-release.json;
  projectFile = "NDecrypt/NDecrypt.csproj";
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net9.0" ];
  dotnetInstallFlags = [ "--framework net9.0" ];

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
