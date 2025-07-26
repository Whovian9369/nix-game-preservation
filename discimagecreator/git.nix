{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  dos2unix
}:

stdenv.mkDerivation rec {
  pname = "discimagecreator";
  version = "20250501";

  src = fetchFromGitHub {
    owner = "saramibreak";
    repo = "DiscImageCreator";
    rev = "a100e2aa7a1bec719a2bc9969bd4f9b04ce6b082";
    hash = "sha256-eCMcvLtrWKg8AS7tCFFMQlXH8fa2DTD4g16EtMtV5YU=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  postPatch = ''
    mkdir -p $out/share/DiscImageCreator
    ${dos2unix}/bin/dos2unix Release_ANSI/default.dat \
      Release_ANSI/driveOffset.txt
    cp LICENSE README.md Release_ANSI/C2ErrorProtect.txt \
      Release_ANSI/ReadErrorProtect.txt Release_ANSI/default.dat \
      Release_ANSI/driveOffset.txt \
      "Release_ANSI/DVDRawBruteforce - Drive Sheet - Sheet1.tsv" \
    $out/share/DiscImageCreator/
    cp -r Release_ANSI/Doc $out/share/DiscImageCreator/
    
    # Replace date string with something more reproducible.
    substituteInPlace meson.build \
       --replace-warn "'date', '+%Y%m%d'" "'echo', '${version}'" \
       --replace-warn "'date', '+%H%M%S'" "'echo', '999999'"
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
