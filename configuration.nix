{ 
  config, 
  pkgs, 
  lib,
  ...
}:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  #nixpkgs.config.packageOverrides = pkgs: rec {
  #  wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
  #    patches = attrs.patches ++ [ ./eduroam.patch ];
  #  });
  #};

  environment.interactiveShellInit = ''
    alias ls="nerdls"
    alias nls="nerdls"
    alias nrs="sudo nixos-rebuild switch"
    alias nrsf="sudo nixos-rebuild switch --flake "
    alias icat24="icat -m 24bit "
  '';
  programs.bash.promptInit = ''
    prompt() {
      PS1="\n $(powerline-rs --shell bash --newline $?)"
    }
    PROMPT_COMMAND=prompt
  '';

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666"
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:porlst/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bunny = {
    isNormalUser = true;
    description = "bunny";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" "adbusers" ];
    packages = with pkgs; [
      # Single User Packages
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font Config
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Noto Sans Mono"
          "Noto Color Emoji"
          "FiraCode"
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Color Emoji"
          "FiraCode"
        ];
        serif = [
          "Noto Serif"
          "Noto Color Emoji"
          "FiraCode"
        ];
      };
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      corefonts
      nerdfonts
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
