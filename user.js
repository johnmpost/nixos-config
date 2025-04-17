// https-only mode
user_pref("dom.security.https_only_mode", true);

// tracking protection
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
user_pref("privacy.donottrackheader.enabled", true);

// never ask to save passwords, credit cards, or addresses
user_pref("signon.rememberSignons", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.addresses.enabled", false);

// don't suggest from sponsors in address bar
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

// don't show pocket or bookmarks on new tab page
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);

// never show bookmark toolbar
user_pref("browser.toolbars.bookmarks.visibility", "never");

// always ask where to save downloads
user_pref("browser.download.useDownloadDir", false);

// make fullscreen just fill the window, leaving the i3bar visible
user_pref("full-screen-api.ignore-widgets", true);

// turn off "firefox-view"
user_pref("browser.tabs.firefox-view", false);

// turn off two-finger swipe for back and forward history navigation
user_pref("browser.gesture.swipe.left", false);
user_pref("browser.gesture.swipe.right", false);


// must do manually:
// - make duckduckgo default search engine
// - switch "website appearance" to dark
// - install ublock origin add-on
//   - configure with all 3 "annoyances" lists
// - install skip-redirect add-on
// - install firefox color add-on
//   - import 222222 theme
// - adjust DDG config
//   - kae=d; 7=222222; ae=d; j=222222
// - install vimium-ff addon
