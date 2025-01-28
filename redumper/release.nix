{ stdenvNoCC
, lib
, fetchzip
}:


stdenvNoCC.mkDerivation rec {
  name = "redumper-bin-v${version}";
  version = "452";
  date = "2025.01.21";

  src = fetchzip {
    url = "https://github.com/superg/redumper/releases/download/build_${version}/redumper-${date}_build${version}-Linux.zip";
    hash = "sha256-ZfrgqVE4SvuAf5u762DV8JwgLUCXoQBPGd9CXBsV/0I=";
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
