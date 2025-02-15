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
  version = "build_479";

  src = fetchFromGitHub {
    owner = "superg";
    repo = "redumper";
    rev = "72f0a93e660884f4085aef69f321720d2e0d7138";
    hash = "sha256-gXUj0pUbkiPrW3WE7QYIZ9nQQPvZecfpH9+jjbnna5g=";
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
