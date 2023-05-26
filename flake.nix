{
  description = "Sparx";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url =  "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              bazel_5
            ]; 
          };
        }
      );
}
