{
  description = "Home Manager configuration of poyehchen";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."poyehchen" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          hyprland.homeManagerModules.default
          ./home.nix
        ] ++ (
          let
            programs = builtins.readDir ./programs;
            files = builtins.attrNames (pkgs.lib.attrsets.filterAttrs (k: v: v == "regular") programs);
            nixes = builtins.filter (f: builtins.match ".*\.nix$" f != null) files;
          in
          builtins.map (f: ./programs + "/${f}") nixes
        );

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
