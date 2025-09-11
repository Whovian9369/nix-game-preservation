{
  lib,
  fetchFromGitHub,
  cmake,
  ninja,
  llvmPackages_18,
  build_type ? "Release",
  # Typical `build_type` values include `Debug`, `Release`, `RelWithDebInfo`
  # and `MinSizeRel`
  # Usually set to "Release" for GitHub Actions use, so that's what it's set to
  # by default here.
}:

llvmPackages_18.libcxxStdenv.mkDerivation {
  pname = "redumper";
  version = "b655";

  src = fetchFromGitHub {
    owner = "superg";
    repo = "redumper";
    rev = "3e737325b6a340709bf2b48c203a5fa0602016bf";
    hash = "sha256-z/T/CJEBXE8mwOAtnjB5bVkIuu0tJtwfn8Y2tTnFAfw=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    llvmPackages_18.clang-tools
  ];

  cmakeFlags = [
    (lib.cmakeBool "CMAKE_BUILD_WITH_INSTALL_RPATH" true)

    # Fix version datestamp to date of `src.rev` commit.
    # It would be nice if I was able to automate this.
    (lib.cmakeFeature "REDUMPER_VERSION_MAJOR" "2025") # Year
    (lib.cmakeFeature "REDUMPER_VERSION_MINOR" "09") # Month
    (lib.cmakeFeature "REDUMPER_VERSION_PATCH" "07") # Day
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
