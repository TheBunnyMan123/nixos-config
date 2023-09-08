{ 
  config, 
  pkgs, 
  lib,
  wrapFirefox,
  fetchFirefoxAddon,
  ...
}:

let 
  customFirefox = pkgs.wrapFirefox pkgs.firefox-esr-unwrapped{
    nixExtensions = [
      (pkgs.fetchFirefoxAddon {
        name = "7tv";
        url = "https://github.com/SevenTV/Extension/releases/download/v3.0.15/7tv-webextension-ext.xpi";
        sha256 = "1e9c989ba968fd4ed851c207140cbfe6a276262f23bc4976f19ad015a70fde30";
      })
      (pkgs.fetchFirefoxAddon {
        name = "ublock-origin";
        url = "https://github.com/gorhill/uBlock/releases/download/1.51.0/uBlock0_1.51.0.firefox.signed.xpi";
        sha256 = "8b73468bc233a11dd2895219466381783d19123857dd0b6fd16a01820fca4834";
      })
      (pkgs.fetchFirefoxAddon {
        name = "sponsorblock";
        url = "https://github.com/ajayyy/SponsorBlock/releases/download/5.4.18/FirefoxSignedInstaller.xpi";
        sha256 = "071c9ad146f2539ef523bca41d6907a692939e670d6f1b3dc965b6c76e65568b";
      })
      (pkgs.fetchFirefoxAddon {
        name = "dark-reader";
        url = "https://github.com/darkreader/darkreader/releases/download/v4.9.65/darkreader-firefox.xpi";
        sha256 = "71adeed9c3ca1494c69cfbbdd57da785d948666ed4e4f635013ec3ea7d61061b";
      })
      (pkgs.fetchFirefoxAddon {
        name = "translate-web-pages";
        url = "https://github.com/FilipePS/Traduzir-paginas-web/releases/download/v9.9.0.2/TWP_9.9.0.2_Firefox.xpi";
        sha256 = "35624d33753b1b3d1b88cb56c5e10e27d3cd1b3ea5144d1d6a3554d33708ec54";
      })
      (pkgs.fetchFirefoxAddon {
        name = "return-youtube-dislikes";
        url = "https://github.com/TheBunnyMan123/return-youtube-dislike/releases/download/v3.0.0.10/return_youtube_dislikes-3.0.0.10.xpi";
        sha256 = "bcf4a5d271341a3dab3337bd6d5328f762c8b6b3447562316c166f902be3ad84";
      })
      (pkgs.fetchFirefoxAddon {
        name = "enhancer-for-youtube";
        url = "https://addons.mozilla.org/firefox/downloads/file/4157491/enhancer_for_youtube-2.0.121.xpi";
        sha256 = "baaba2f8eef7166c1bee8975be63fc2c28d65f0ee48c8a0d1c1744b66db8a2ad";
      })
      (pkgs.fetchFirefoxAddon {
        name = "emoji";
        url = "https://github.com/Sav22999/emoji/releases/download/3.19/emoji-firefox-3-19.zip";
        sha256 = "3483c6e4767065f9e859cfd9b2756bdc46f3a9034e25dc422c3f21033447628f";
      })
    ];
  
    # https://github.com/yokoffing/Betterfox
    extraPrefs = ''
      lockPref("xpinstall.signatures.required", false);
      lockPref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
      lockPref("dom.security.https_only_mode", true);
      lockPref("dom.security.https_only_mode_ever_enabled", true);
      lockPref("privacy.trackingprotection.enabled", true);
      lockPref("app.update.suppressPrompts", true);
      lockPref("browser.privatebrowsing.vpnpromourl", "");
      lockPref("browser.shell.checkDefaultBrowser", false);
      lockPref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
      lockPref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
      lockPref("browser.preferences.moreFromMozilla", false);
      lockPref("browser.tabs.tabmanager.enabled", false);
      lockPref("full-screen-api.transition-duration.enter", "0 0");
      lockPref("full-screen-api.transition-duration.leave", "0 0");
      lockPref("full-screen-api.warning.delay", -1);
      lockPref("full-screen-api.warning.timeout", 0);
      lockPref("browser.aboutwelcome.enabled", false);
      lockPref("findbar.highlightAll", true);
      lockPref("browser.urlbar.suggest.engines", false);
      lockPref("browser.urlbar.suggest.topsites", false);
      lockPref("browser.urlbar.suggest.calculator", true);
      lockPref("browser.urlbar.unitConversion.enabled", true);
      lockPref("browser.newtabpage.activity-stream.feeds.topsites", false);
      lockPref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
      lockPref("extensions.pocket.enabled", false);
      lockPref("browser.download.useDownloadDir", false);
      lockPref("browser.download.manager.addToRecentDocs", true);
      lockPref("browser.download.always_ask_before_handling_new_types", true);
      lockPref("browser.download.autohideButton", false);
      lockPref("dom.disable_window_move_resize", true);
      lockPref("layout.css.has-selector.enabled", true);
      lockPref("browser.contentblocking.category", "standard");
      lockPref("privacy.query_stripping.enabled", true);
      lockPref("privacy.query_stripping.enabled.pbmode", true);
      lockPref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
      lockPref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
      lockPref("fission.autostart", true);
      lockPref("security.sandbox.gpu.level", 1);
      lockPref("network.cookie.cookieBehavior", 5);
      lockPref("browser.contentblocking.reject-and-isolate-cookies.preferences.ui.enabled", true);
      lockPref("privacy.partition.network_state", true);
      lockPref("privacy.partition.serviceWorkers", true);
      lockPref("privacy.partition.always_partition_third_party_non_cookie_storage", true);
      lockPref("privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage", false);
      lockPref("extensions.webcompat.enable_shims", true);
      lockPref("privacy.purge_trackers.enabled", true);
      lockPref("browser.send_pings", false);
      lockPref("privacy.globalprivacycontrol.enabled", true);
      lockPref("privacy.globalprivacycontrol.functionality.enabled", true);
      lockPref("accessibility.blockautorefresh", true);
      lockPref("network. http. redirection-limit", 10);
      lockPref("extensions.update.enabled", false);
    '';
  
    extraPolicies = {
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableAppUpdate = true;
      DisableFormHistory = true;
      DisableProfileRefresh = true;
      DisableProfileImport = true;
      DisableSystemAddonUpdate = true;
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      OfferToSaveLogins = false;
      PromptForDownloadLocation = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
    };
  };
in {
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    nano
    customFirefox
    virt-manager
    qemu_kvm
    vscode
    flatpak
    vlc
    gnome-photos
    gnome.gnome-screenshot
    gnome-console
    gnome.gnome-system-monitor
    gparted
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
    gnome.gnome-themes-extra
    git
    appimage-run
    gnome.nautilus
    #discord
    libvirt
    yt-dlp
    ffmpeg
    home-manager
    wget
    curl
    nssmdns
    citra-canary
    steam
    pmutils
    p7zip
    thunderbird
    gnome.gnome-remote-desktop
    spotify
    hashcat
    pkgs.gnome3.gnome-tweaks
    libreoffice
    python3Full
    dotnet-sdk
    python3
    headsetcontrol
    gnomeExtensions.headsetcontrol
    distrobox
    gimp
    docker
    shotcut
    tor-browser-bundle-bin
    git-credential-manager
    github-cli
    dotnet-runtime
    browsh
    baobab
    wine64
    winetricks

    # Local derivations
    (callPackage ./tilp.nix { })
    (callPackage ./icat.nix { })
  ];
  
  # Get rid of most default packages
  environment.gnome.excludePackages = with pkgs.gnome; [ 
    baobab 
    epiphany 
    simple-scan 
    yelp evince 
    gnome-calculator 
    gnome-calendar 
    gnome-characters 
    gnome-clocks 
    gnome-contacts 
    gnome-font-viewer 
    gnome-logs 
    gnome-maps 
    gnome-music 
    gnome-weather 
    gnome-disk-utility 
    pkgs.gnome-tour 
    cheese 
    geary 
    gnome-keyring
    gnome-software
  ];
}
