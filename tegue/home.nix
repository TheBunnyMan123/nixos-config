# The home.stateVersion option does not have a default and must be set
home.stateVersion = "23.05";
# Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
    
# Add Firefox GNOME theme directory
home.file."firefox-gnome-theme" = {
target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
source = (fetchTarball {
  url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/master.tar.gz";
  sha256 = "11m1cglhzkj9r0bnjbci3dy4sijsmahdqdzgjnq1hhvdb5a5gpf8";
});
};
    
dconf.settings = {
  "org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
  };
};
    
programs.firefox = {
enable = true;
profiles = {
  default = {
    isDefault = true;
    name = "Default";
    settings = {
      # https://github.com/yokoffing/Betterfox
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_ever_enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "app.update.suppressPrompts" = true;
      "browser.privatebrowsing.vpnpromourl" = "";
      "browser.shell.checkDefaultBrowser" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
      "browser.preferences.moreFromMozilla" = false;
      "browser.tabs.tabmanager.enabled" = false;
      "full-screen-api.transition-duration.enter" = "0 0";
      "full-screen-api.transition-duration.leave" = "0 0";
      "full-screen-api.warning.delay" = -1;
      "full-screen-api.warning.timeout" = 0;
      "browser.aboutwelcome.enabled" = false;
      "findbar.highlightAll" = true;
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.topsites" = false;
      "browser.urlbar.suggest.calculator" = true;
      "browser.urlbar.unitConversion.enabled" = true;
      "browser.newtabpage.activity-stream.feeds.topsites" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "extensions.pocket.enabled" = false;
      "browser.download.useDownloadDir" = false;
      "browser.download.manager.addToRecentDocs" = true;
      "browser.download.always_ask_before_handling_new_types" = true;
      "browser.download.autohideButton" = false;
      "dom.disable_window_move_resize" = true;
      "layout.css.has-selector.enabled" = true;
      "browser.contentblocking.category" = "standard";
      "privacy.query_stripping.enabled" = true;
      "privacy.query_stripping.enabled.pbmode" = true;
      "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
      "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
      "fission.autostart" = true;
      "security.sandbox.gpu.level" = 1;
      "network.cookie.cookieBehavior" = 5;
      "browser.contentblocking.reject-and-isolate-cookies.preferences.ui.enabled" = true;
      "privacy.partition.network_state" = true;
      "privacy.partition.serviceWorkers" = true;
      "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
      "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false;
      "extensions.webcompat.enable_shims" = true;
      "privacy.purge_trackers.enabled" = true;
      "browser.send_pings" = false;
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.globalprivacycontrol.functionality.enabled" = true;

      # For Firefox GNOME theme:
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.tabs.drawInTitlebar" = true;
      "svg.context-properties.content.enabled" = true;
    };
    userChrome = ''
      @import "firefox-gnome-theme/userChrome.css";
      @import "firefox-gnome-theme/theme/colors/dark.css"; 
    '';
   };
 };
