{
  stdenvNoCC,
  lib,
  fetchzip
}:


stdenvNoCC.mkDerivation rec {
  name = "redumper-bin-b${version}";
  version = "b774";

  src = fetchzip {
    url = "https://github.com/superg/redumper/releases/download/${version}/redumper-${version}-linux-x64.zip";
    hash = "sha256-O/ldkV+DvwtriLhUr8ghsyCzj4qqBSQMqsSfewU7SW0=";
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
