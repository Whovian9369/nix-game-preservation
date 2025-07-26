{
  description = "A few game preservation related Nix packages.";

  inputs = {
    # The nixos-unstable branch of the NixOS/nixpkgs repository on GitHub.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages.x86_64-linux = {
    # DiscImageCreator
      discimagecreator = self.packages.x86_64-linux.dic-release-full;
      dic-release = pkgs.callPackage discimagecreator/package.nix {};
      dic-release-full = pkgs.symlinkJoin {
        pname = "DiscImageCreator-full";
        version = "${self.packages.x86_64-linux.dic-release.version}";
        paths = [ self.packages.x86_64-linux.dic-release self.packages.x86_64-linux.dic-eccedc self.packages.x86_64-linux.dic-unscrambler self.packages.x86_64-linux.dic-dvdauth ];
        meta = {
          description = "DiscImageCreator + EccEdc + Unscrambler + DVDAuth";
          homepage = "https://github.com/saramibreak/DiscImageCreator";
        };
      };
      dic-git = pkgs.callPackage discimagecreator/git.nix {};
      dic-git-full = pkgs.symlinkJoin {
        pname = "DiscImageCreator-full";
        version = "${self.packages.x86_64-linux.dic-git.version}";
        paths = [ self.packages.x86_64-linux.dic-git self.packages.x86_64-linux.dic-eccedc self.packages.x86_64-linux.dic-unscrambler self.packages.x86_64-linux.dic-dvdauth ];
        meta = {
          description = "DiscImageCreator + EccEdc + Unscrambler + DVDAuth";
          homepage = "https://github.com/saramibreak/DiscImageCreator";
        };
      };
      dic-eccedc = pkgs.callPackage discimagecreator/eccedc.nix {};
      dic-eccedc-git = pkgs.callPackage discimagecreator/eccedc-git.nix {};
      dic-unscrambler = pkgs.callPackage discimagecreator/unscrambler.nix {};
      dic-dvdauth = pkgs.callPackage discimagecreator/dvdauth.nix {};

    # NDecrypt
      ndecrypt = self.packages.x86_64-linux.ndecrypt-release;
      ndecrypt-bin = pkgs.callPackage ndecrypt/bin.nix {};
      ndecrypt-release = pkgs.callPackage ndecrypt/release.nix {};
      ndecrypt-git = pkgs.callPackage ndecrypt/git.nix {};

    # Redumper
      redumper = self.packages.x86_64-linux.redumper-release;
      redumper-release = pkgs.callPackage redumper/release.nix {};
      redumper-git = pkgs.callPackage redumper/package.nix {};

    # SabreTools
      sabretools = self.packages.x86_64-linux.sabretools-git;
      sabretools-release = pkgs.callPackage sabretools/package.nix {};
      sabretools-git = pkgs.callPackage sabretools/git.nix {};

    # UnshieldSharp
      unshieldsharp = self.packages.x86_64-linux.unshieldsharp-release;
      unshieldsharp-release = pkgs.callPackage unshieldsharp/release.nix {};
      unshieldsharp-git = pkgs.callPackage unshieldsharp/git.nix {};

    };
  };
}
