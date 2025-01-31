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

llvmPackages.libcxxStdenv.mkDerivation /* rec */ {
  pname = "redumper";
  version = "build_458";

  src = fetchFromGitHub {
    owner = "superg";
    repo = "redumper";
    rev = "1e3f4c28395aaa744502ad9566eb23b8b92e60a0";
    hash = "sha256-qpHSzFlSy+MRVnOUOS4SyKfx3y5KVvD5eqUDzNoeyxo=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    llvmPackages.clang-tools
  ];

  patches = [
    ./remove_compiler_warnings.diff
      # Remove warning:
      # clang++: warning: argument unused during compilation: '-stdlib=libc++' [-Wunused-command-line-argument]
    ./build_timestamp.diff
      # Change timestamp variables to be "CACHE" ones that can be overridden.
      # This lets us force various date values to match `src.rev` date.
  ];

  # Originally based on
  # https://github.com/superg/redumper/blob/main/.github/workflows/cmake.yml
  cmakeFlags = [
    (lib.cmakeBool "CMAKE_BUILD_WITH_INSTALL_RPATH" true)
    (lib.cmakeFeature "REDUMPER_CLANG_LINK_OPTIONS" "")
      # overrides the '-static' default

    # Fix version datestamp to date of `src.rev` commit.
    # See notes for build_timestamp.diff patch
    (lib.cmakeFeature "REDUMPER_VERSION_MAJOR" "2025") # Year
    (lib.cmakeFeature "REDUMPER_VERSION_MINOR" "01") # Month
    (lib.cmakeFeature "REDUMPER_VERSION_PATCH" "31") # Day
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
