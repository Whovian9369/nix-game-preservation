{
  stdenvNoCC,
  lib,
  fetchzip
}:


stdenvNoCC.mkDerivation rec {
  name = "redumper-bin-b${version}";
  version = "658";

  src = fetchzip {
    url = "https://github.com/superg/redumper/releases/download/b${version}/redumper-b${version}-linux-x64.zip";
    hash = "sha256-4l2rROvcemTackAUFYtlmOaXoLZzKBSoDk1iBF5BM7A=";
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
