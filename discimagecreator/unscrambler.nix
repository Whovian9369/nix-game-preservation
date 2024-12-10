{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "unscrambler";
  version = "0.5.5";

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "unscrambler";
    rev = "ffbf48a271e734c8fd34128d76d4c0b6c51f541f";
    hash = "sha256-nwqJJi3aSbc8k5Vd1Tz/Du6yVw2MbHuusjoFtu3S/dc=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm755 -t $out/bin unscrambler.out
    runHook postInstall
  '';

  meta = {
    description = "Unscramble not standard IVs scrambled DVDs thru  bruteforce, intended for Gamecube/WII Optical Disks";
    homepage = "https://github.com/saramibreak/unscrambler";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "unscrambler";
    platforms = lib.platforms.all;
  };
}
