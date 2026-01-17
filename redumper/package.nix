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
  version = "b685";

  src = fetchFromGitHub {
    owner = "superg";
    repo = "redumper";
    rev = "cfad4293215c4d9a2c00797ae9e4c3df8a6e7c70";
    hash = "sha256-bh4LdvueOeAxqNEZ0jpuZG5kZ7xyWz/j0ZIlXi+m1n8=";
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
