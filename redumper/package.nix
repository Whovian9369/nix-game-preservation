{
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
  llvmPackages,
  build_type ? "Release",
  # Typical `build_type` values include `Debug`, `Release`, `RelWithDebInfo`
  # and `MinSizeRel`
  # Usually set to "Release" for GitHub Actions use, so that's what it's set to
  # by default here.
}:

llvmPackages.libcxxStdenv.mkDerivation {
  pname = "redumper";
  version = "build_503";

  src = fetchFromGitHub {
    owner = "superg";
    repo = "redumper";
    rev = "bdedce6292307bb794fb99dd21e68d40eba392f1";
    hash = "sha256-V5W2Y2cp5pwaSALePoU+m7+jyTvVaTVtGYP/Vtn/u5E=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    llvmPackages.clang-tools
  ];

  cmakeFlags = [
    (lib.cmakeBool "CMAKE_BUILD_WITH_INSTALL_RPATH" true)

    # Fix version datestamp to date of `src.rev` commit.
    # It would be nice if I was able to automate this.
    (lib.cmakeFeature "REDUMPER_VERSION_MAJOR" "2025") # Year
    (lib.cmakeFeature "REDUMPER_VERSION_MINOR" "02") # Month
    (lib.cmakeFeature "REDUMPER_VERSION_PATCH" "09") # Day
    (lib.cmakeFeature "REDUMPER_VERSION_BUILD" "NixOS")
  ];

  meta = {
    description = "Low level CD dumper utility";
    homepage = "https://github.com/superg/redumper";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "redumper";
    platforms = lib.platforms.linux;
  };
}
