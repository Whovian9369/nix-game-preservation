{
  lib,
  llvmPackages_18,
  fetchFromGitHub,
  cmake,
  ninja,
  build_type ? "Release",
  # Typical `build_type` values include `Debug`, `Release`, `RelWithDebInfo`
  # and `MinSizeRel`
  # Usually set to "Release" for GitHub Actions use, so that's what it's set to
  # by default here.
}:

llvmPackages_18.libcxxStdenv.mkDerivation rec {
  pname = "redumper";
  version = "build_438";

  src = fetchFromGitHub {
    owner = "superg";
    repo = "redumper";
    rev = version;
    hash = "sha256-Ft+fxrKt7Yue+JT6PydWIzwbKGBX/VzLjjsADD7mqy0=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    (llvmPackages_18.clang-tools.override { enableLibcxx = true; })
  ];

  env.gh_run_version = lib.removePrefix "build_" version;

  cmakeFlags = [
    "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON"
    "-DREDUMPER_VERSION_BUILD=${env.gh_run_version}"
    "-DREDUMPER_CLANG_LINK_OPTIONS="
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace-fail '"-static"' "" \
      --replace-fail '(-stdlib=libc++' "(" \
      --replace-fail \
        'add_compile_options($<$<COMPILE_LANGUAGE:CXX>:-stdlib=libc++>)' ""
  '';
    # Use of "-static" appears to break build.
    # Use of "-stdlib=libc++" appears to be unused according to logs.
    # Use of "-stdlib=libc++" appears to be unused according to logs.

  meta = {
    description = "Low level CD dumper utility";
    homepage = "https://github.com/superg/redumper";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "redumper";
    platforms = lib.platforms.all;
  };
}
