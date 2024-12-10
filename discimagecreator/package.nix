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
    rev = "1e8c556b7f307cc9d681d8f735301c5fa9bc3cff";
    hash = "sha256-o2ntnwg1UX9qztw9z3+Dnb2INeKXPn5WVbicocOdJlU=";
  };

  nativeBuildInputs = [
    meson
    ninja
  ];

  meta = {
    description = "This is the disc (CD, GD, DVD, HD-DVD, BD, GC/Wii, XBOX, XBOX 360) and disk (Floppy, MO, USB etc) image creation tool";
    homepage = "https://github.com/saramibreak/DiscImageCreator";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "discimagecreator";
    platforms = lib.platforms.all;
  };
}