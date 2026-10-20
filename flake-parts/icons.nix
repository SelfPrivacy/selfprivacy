{ ... }:
{
  perSystem =
    {
      self',
      pkgs,
      lib,
      ...
    }:
    let
      source = lib.fileset.toSource {
        root = ../.;
        fileset = lib.fileset.unions [
          ../assets/icons/brand
          ../brand_icons.json
          ../lib/generated/brand_icons
        ];
      };
      tools = [
        self'.packages.glyphpact
        pkgs.coreutils
      ];
    in
    {
      packages.generate-icons = pkgs.writeShellApplication {
        name = "generate-icons";
        runtimeInputs = tools;
        text = ''glyphpact --config brand_icons.json "$@"'';
      };
      packages.check-icons = pkgs.writeShellApplication {
        name = "check-icons";
        runtimeInputs = tools;
        text = ''
          scratch=$(mktemp -d)
          trap 'rm -rf "$scratch"' EXIT
          mkdir -p "$scratch/assets/icons" "$scratch/lib/generated"
          cp brand_icons.json "$scratch/"
          cp -R assets/icons/brand "$scratch/assets/icons/"
          cp -R lib/generated/brand_icons "$scratch/lib/generated/"
          chmod -R u+w "$scratch"
          cd "$scratch"
          glyphpact --config brand_icons.json --check
        '';
      };
      apps = lib.genAttrs [ "generate-icons" "check-icons" ] (name: {
        type = "app";
        program = "${self'.packages.${name}}/bin/${name}";
      });
      checks.icons = pkgs.runCommand "check-brand-icons" { } ''
        cd ${source}
        ${self'.packages.check-icons}/bin/check-icons
        touch "$out"
      '';
      devShells.icons = pkgs.mkShellNoCC { nativeBuildInputs = tools; };
    };
}
