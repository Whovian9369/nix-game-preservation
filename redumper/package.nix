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
  gtest
}:

llvmPackages_18.libcxxStdenv.mkDerivation {
  pname = "redumper";
  version = "b716";

  src = fetchFromGitHub {
    owner = "superg";
    repo = "redumper";
    rev = "edb4a09fe10ffb847bbf80c61585c6857ca00848";
    hash = "sha256-fco81TNJfa2O0TflBXRfjL0utKeYkE7051syJJkjYTU=";
  };

  cmakeBuildType = "${build_type}";

  nativeBuildInputs = [
    cmake
    ninja
    llvmPackages_18.clang-tools
  ];

  # For some reason, this lets the build pass by finding the right headers.
  # Thanks for finding this, github:@hughobrien !
  # See PR https://github.com/NixOS/nixpkgs/pull/463291
  env.NIX_CFLAGS_COMPILE = "-isystem ${llvmPackages_18.libcxx.dev}/include/c++/v1";

  cmakeFlags = [
    (lib.cmakeBool "CMAKE_BUILD_WITH_INSTALL_RPATH" true)

    (lib.cmakeFeature "FETCHCONTENT_SOURCE_DIR_GOOGLETEST" "${gtest.src}")

    # Fix version datestamp to date of `src.rev` commit.
    # It would be nice if I was able to automate this.
    (lib.cmakeFeature "REDUMPER_VERSION_MAJOR" "2026") # Year
    (lib.cmakeFeature "REDUMPER_VERSION_MINOR" "04") # Month
    (lib.cmakeFeature "REDUMPER_VERSION_PATCH" "24") # Day
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
