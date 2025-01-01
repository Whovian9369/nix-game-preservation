{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub
}:

buildDotnetModule {
  pname = "unshieldsharp";
  version = "1.9.4";

  src = fetchFromGitHub {
    owner = "mnadareski";
    repo = "UnshieldSharp";
    rev = "184222c19b10d890e8125d34ae0d45220031fdfd";
    hash = "sha256-smwrWcUf/TWw6pXSh1ylq+vf+xtZyrnXJsrJTGxoeQ4=";
  };

  dotnet-sdk = dotnetCorePackages.sdk_9_0;
  dotnet-runtime = dotnetCorePackages.runtime_9_0;
  nugetDeps = ./deps-release.json;
  projectFile = "Test/Test.csproj";
  selfContainedBuild = false;
  dotnetBuildFlags = [ "--framework net9.0" ];
  dotnetInstallFlags = [ "--framework net9.0" ];

  executables = [ "Test" ];

  preFixup = ''
    mv $out/bin/Test $out/bin/unshieldsharp
  '';

  meta = {
    description = "Port of Unshield to C";
    homepage = "https://github.com/mnadareski/UnshieldSharp";
    license = with lib.licenses; [ mit asl20 ];
    maintainers = with lib.maintainers; [ ];
    mainProgram = "unshieldsharp";
    platforms = lib.platforms.all;
  };
}
