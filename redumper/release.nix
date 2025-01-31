{ stdenvNoCC
, lib
, fetchzip
}:


stdenvNoCC.mkDerivation rec {
  name = "redumper-bin-v${version}";
  version = "456";
  date = "2025.01.29";

  src = fetchzip {
    url = "https://github.com/superg/redumper/releases/download/build_${version}/redumper-${date}_build${version}-Linux.zip";
    hash = "sha256-B8WHJnYk9OGSFGhvdZhyun7P0eevyJColjbgLVIVowM=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm755 -t $out/bin bin/redumper
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
}
