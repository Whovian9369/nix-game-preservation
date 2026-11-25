{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "eccedc";
  version = "20240901-unstable-2025-01-15";

  sourceRoot = "${src.name}/EccEdc";

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "EccEdc";
    rev = "427dd5713718f5a4d2f500da0ce457ce1bebd8a2";
    hash = "sha256-iV49dxkXecEjSOvJYWAnqbU7oaSQuKzgzPUTniBOOvc=";
  };

  env.PREFIX="$(out)";

  preBuild = ''
    substituteInPlace _external/ecm.cpp --replace-fail '#include "ecm.h"' \
      $'#include "ecm.h"\n#include <cstdint>'
  '';

  preInstall = ''
    mkdir -p $out/bin
  '';

  meta = {
    description = "Checks or fix user data of the 2048 byte per sector of CD by using ecc/edc";
    homepage = "https://github.com/saramibreak/EccEdc";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "eccedc";
    platforms = lib.platforms.all;
  };
}
