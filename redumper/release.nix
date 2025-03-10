{ stdenvNoCC
, lib
, fetchzip
}:


stdenvNoCC.mkDerivation rec {
  name = "redumper-bin-v${version}";
  version = "503";
  date = "2025.03.09";

  src = fetchzip {
    url = "https://github.com/superg/redumper/releases/download/build_${version}/redumper-${date}_build${version}-Linux64.zip";
    hash = "sha256-p0R1kwbgL3Cib+hoSv965tfWNbdHvsdWJzUUggxuNJU=";
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
