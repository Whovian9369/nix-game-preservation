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
      dic-release-full = pkgs.symlinkJoin { name = "DiscImageCreator (Full)"; paths = [ self.packages.x86_64-linux.dic-release self.packages.x86_64-linux.dic-eccedc ]; };
      dic-git = pkgs.callPackage discimagecreator/git.nix {};
      dic-git-full = pkgs.symlinkJoin { name = "DiscImageCreator (Full)"; paths = [ self.packages.x86_64-linux.dic-git self.packages.x86_64-linux.dic-eccedc ]; };
      dic-eccedc = pkgs.callPackage discimagecreator/eccedc.nix {};

      # Redumper
      redumper = self.packages.x86_64-linux.redumper-bin;
      redumper-bin = nixpkgs.legacyPackages.x86_64-linux.callPackage redumper/bin.nix {};
      redumper-git = nixpkgs.legacyPackages.x86_64-linux.callPackage redumper/package.nix {};
    };
  };
}
