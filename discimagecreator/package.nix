{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
}:

stdenv.mkDerivation {
  pname = "discimagecreator";
  version = "20250101";

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "DiscImageCreator";
    rev = "5126ba5ae028fd589aaeaf56c7878d4e295e81c1";
    hash = "sha256-D4hRsroYCV6JKODMNGDw5FCfIQVtw7KmijopOCqhroI=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  postPatch = ''
    mkdir -p $out/share/DiscImageCreator
    cp LICENSE README.md Release_ANSI/C2ErrorProtect.txt Release_ANSI/ReadErrorProtect.txt $out/share/DiscImageCreator/
    cp "Release_ANSI/DVDRawBruteforce - Drive Sheet - Sheet1.tsv" $out/share/DiscImageCreator/
    cp -r Release_ANSI/Doc $out/share/DiscImageCreator/
  '';

  meta = {
    description = "This is the disc (CD, GD, DVD, HD-DVD, BD, GC/Wii, XBOX, XBOX 360) and disk (Floppy, MO, USB etc) image creation tool";
    homepage = "https://github.com/saramibreak/DiscImageCreator";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "discimagecreator";
    platforms = lib.platforms.all;
  };
}
