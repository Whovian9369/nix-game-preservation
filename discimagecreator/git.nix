{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
}:

stdenv.mkDerivation {
  pname = "discimagecreator";
  version = "20241001";

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "DiscImageCreator";
    rev = "6c7d0731441989783a7ee12aa42e0a44984a9e2d";
    hash = "sha256-Hru4o8aOZaLY69qSm+hZkG2dRC4S2QWBEqbPl80f468=";
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
