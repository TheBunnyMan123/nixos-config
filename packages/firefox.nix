{ 
  config, 
  pkgs, 
  lib,
  wrapFirefox,
  fetchFirefoxAddon,
  ...
}:

pkgs.wrapFirefox pkgs.firefox-devedition-unwrapped{#firefox-esr-unwrapped{
  # nixExtensions = [
  #   (pkgs.fetchFirefoxAddon {
  #     name = "twitch5";
  #     url = "https://addons.mozilla.org/firefox/downloads/file/4171740/twitch_5-2022.2.7.1.xpi";
  #     sha256 = "sha256-8O3b2STIkEyo33t58HesKHePa3h9UGiuV6PamuVtDho=";
  #   })
  # ];

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
    lockPref("browser.requireSigning", false);
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
    lockPref("browser.ssb.enabled", true);
    lockPref("browser.uiCustomization.state", '{"placements":{"widget-overflow-fixed-list":["firefox-view-button","fxa-toolbar-menu-button"],"unified-extensions-area":["nixos_7tv-browser-action","nixos_sponsorblock-browser-action","nixos_dark-reader-browser-action","nixos_ublock-origin-browser-action","nixos_translate-web-pages-browser-action","nixos_return-youtube-dislikes-browser-action","nixos_enhancer-for-youtube-browser-action","nixos_decentraleyes-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","customizableui-special-spring14","urlbar-container","save-to-pocket-button","search-container","downloads-button","developer-button","unified-extensions-button","nixos_emoji-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["alltabs-button","tabbrowser-tabs","new-tab-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","nixos_7tv-browser-action","nixos_sponsorblock-browser-action","nixos_dark-reader-browser-action","nixos_ublock-origin-browser-action","nixos_translate-web-pages-browser-action","nixos_return-youtube-dislikes-browser-action","nixos_enhancer-for-youtube-browser-action","nixos_emoji-browser-action","nixos_decentraleyes-browser-action"],"dirtyAreaCache":["nav-bar","toolbar-menubar","TabsToolbar","PersonalToolbar","unified-extensions-area","widget-overflow-fixed-list"],"currentVersion":19,"newElementCount":34}')
    lockPref("keyword.enabled", true);
  '';

  extraPolicies = {
    ExtensionSettings = {
      "*" = {
        blocked_install_message = "Please install extensions through Nix Config.";
        installation_mode = "blocked";
        allowed_types = ["extension"];
        updates_disabled = false;
        default_area = "menupanel";
      };
      "uBlock0@raymondhill.net" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        default_area = "menupanel";
      };
      "addon@darkreader.org" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        default_area = "menupanel";
      };
      "moz-addon@7tv.app" = {
        installation_mode = "force_installed";
        install_url = "https://github.com/SevenTV/Extension/releases/download/nightly-release/7tv-webextension-ext.xpi";
        default_area = "menupanel";
      };
      "emoji@saveriomorelli.com" = { # Emoji
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/emoji-sav/latest.xpi";
        default_area = "navbar";
      };
      "trasnslate-web-pages" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/traduzir-paginas-web/latest.xpi";
        default_area = "menupanel";
      };
      "sponsorBlocker@ajay.app" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        default_area = "menupanel";
      };
      "return-youtube-dislike" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
        default_area = "menupanel";
      };
      "ruffle" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ruffle_rs/latest.xpi";
        default_area = "menupanel";
      };
      "ttv-lol-pro-(twitch-adblock)" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ttv-lol-pro/latest.xpi";
        default_area = "menupanel";
      };
    };
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
}
