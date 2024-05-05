{inputs, outputs, lib, config, pkgs, ...}: {
  home = {
    username = "bunny";
    homeDirectory = "/home/bunny";
    stateVersion = "23.05";
  };

#  imports = [inputs.catppuccin.homeManagerModules.catppuccin];

#  gtk = {
##    enable = true;

 #   catppuccin = {
 #     enable = true;
 #     flavor = "mocha";
 #     accent = "cyzn";
 #     size = "standard";
 #     tweaks = [ "normal" ];
#
 #     cursors = {
 #       enable = true;
 #       accent = "cyan";
 #       flavor = "macchiato";
 #     };
 #   };
 # };
}
