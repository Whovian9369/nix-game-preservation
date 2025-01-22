{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "eccedc";
  version = "unstable-2025-01-15";

  sourceRoot = "${src.name}/EccEdc";

  preBuild = ''
    substituteInPlace _external/ecm.cpp --replace-fail '#include "ecm.h"' \
      $'#include "ecm.h"\n#include <cstdint>'
  '';

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "EccEdc";
    rev = "bcdf432e27d2867ef487769a91682ad2b1160cb5";
    hash = "sha256-KrirSQh021afoLd1EGTTnSyx8Rs9Rw4bg9IAm6DDtYM=";
  };

  env.PREFIX="$(out)";

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
