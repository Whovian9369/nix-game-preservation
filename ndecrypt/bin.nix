{
  stdenvNoCC,
  lib,
  autoPatchelfHook,
  dotnetCorePackages,
  fetchzip,
  gcc,
  makeWrapper,
  openssl,
  zlib
}:


stdenvNoCC.mkDerivation (finalAttrs: {
  name = "ndecrypt-bin";
  version = "0.7.0";

  src = fetchzip {
    url = "https://github.com/SabreTools/NDecrypt/releases/download/${finalAttrs.version}/NDecrypt_${finalAttrs.version}_net11.0_linux-x64_release.zip";
    hash = "sha256-CTISJETw4Gm8FdwBthc8fb3/tHLUfU31JRk2kTvPilM=";
    # stripRoot = false;
  };

  buildInputs = [
    autoPatchelfHook
    makeWrapper
    gcc.cc
    zlib
  ];

  dontStrip = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -Dm755 NDecrypt -T $out/bin/ndecrypt
    wrapProgram $out/bin/ndecrypt \
      --set DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 1 \
      --set DOTNET_ROOT ${dotnetCorePackages.runtime_11_0} \
      --set LD_LIBRARY_PATH ${lib.makeLibraryPath [ openssl ]}
    runHook postInstall
  '';


  meta = {
    description = "Low level CD dumper utility.";
    homepage = "https://github.com/superg/redumper";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "redumper";
    platforms = lib.platforms.all;
  };
})
