{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "eccedc";
  version = "20240901";

  sourceRoot = "${src.name}/EccEdc";

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "EccEdc";
    rev = "4b744f511023f3ea093441faaf73cf79e218ec67";
    hash = "sha256-rczhwzGLaZE6JiXhe/+zPkPlSO5P12Kf5DOU4HYfto0=";
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
