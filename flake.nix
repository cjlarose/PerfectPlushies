{
  description = "Perfect Plushies Minecraft mod dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            jdk17
            jdk21
          ];

          shellHook = ''
            export JAVA_HOME="${pkgs.jdk17.home}"
            export JAVA_17_HOME="${pkgs.jdk17.home}"
            export JAVA_21_HOME="${pkgs.jdk21.home}"
            echo "Perfect Plushies dev environment"
            echo "Java: $(java -version 2>&1 | head -1)"
          '';
        };
      });
}
