{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "ndecrypt";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "SabreTools";
    repo = "NDecrypt";
    rev = "abf0843d22091f03303b563ed0d2ed894138a2c1";
    hash = "sha256-1WY019Th3RVONfI6WegozGQq2/Zi2b1gMLBtcfRSqIw=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-git.json;
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
