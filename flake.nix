{
  nixConfig.bash-prompt = "\[selfprivacy\]$ ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      #nixpkgs-unstable,
      flake-parts,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        ./flake-parts/shared.nix
        ./flake-parts/packages.nix
        ./flake-parts/runnables.nix
        ./flake-parts/shells.nix
      ];

      perSystem =
        {
          self',
          pkgs,
          system,
          lib,
          sp,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;

            config = {
              allowUnfree = true;
              android_sdk.accept_license = true;
            };

            overlays = [
              # (final: prev: {
              #   pkgs-unstable = import nixpkgs-unstable {
              #     inherit system;

              #     config = {
              #       allowUnfree = true;
              #       android_sdk.accept_license = true;
              #     };
              #   };
              # })
            ];
          };
        };
    };
}
