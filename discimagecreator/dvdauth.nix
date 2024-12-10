{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "dvdauth";
  version = "1.4";

  sourceRoot = "${src.name}/DVDAuth";

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "DVDAuth";
    rev = "708cf70429877d44619260feafa437d65b2994a1";
    hash = "sha256-KXSynLSUqAfwumkh0s0eHYQDeKelF6v0nisuDwOeIOI=";
  };

  env.PREFIX = "$(out)";

  preInstall = ''
    mkdir -p $out/bin
  '';

  meta = {
    description = "This is CSS or CPPM or CPRM authentication tool";
    homepage = "https://github.com/saramibreak/DVDAuth";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "dvd-auth";
    platforms = lib.platforms.all;
  };
}

