{ config, lib, pkgs, inputs, ... }:

{
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    vim
    alacritty
    git
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    python314
    neofetch
    ripgrep
    tree
    scrot
    ungoogled-chromium
    gnucash
    xclip
    nodejs_24
    keepassxc
    ffmpeg_6
    pulseaudio
    pavucontrol
    xss-lock
    i3lock
    lesspipe
    pkg-config
    picom
    xorg.xmodmap
    hsetroot
    jq
    openssl
    zip
    unzip
    feh
    proverif
    wkhtmltopdf
    rclone
    yt-dlp
    vlc
    imagemagick
    piper
    ddcutil
  ];

  programs = {
    home-manager.enable = true;
  };

  programs.nixvim = (import ./nixvim.nix { inherit inputs pkgs; });
  home.file.".config/nvim/queries/ledger/highlights.scm".source = ./nvim/queries/ledger/highlights.scm;


  programs.firefox = {
    enable = true;

    policies = {
      ExtensionSettings = {
	"batterdarkerdocs@threethan.github.io" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/latest/better-darker-docs/latest.xpi";
	  installation_mode = "force_installed";
	};
      };
    };

    profiles.john = {
      search = {
	force = true;
	default = "ddgc";
	privateDefault = "ddgc";
	engines = {
	  bing.metaData.hidden = true;
	  ddg.metaData.hidden = true;
	  google.metaData.hidden = true;
	  wikipedia.metaData.hidden = true;
	  amazon.metaData.hidden = true;
	  ebay.metaData.hidden = true;
	  ddgc = {
	    name = "DuckDuckGo (themed)";
	    urls = [{ template = "https://duckduckgo.com/?k7=222222&kj=222222&kae=d&q={searchTerms}"; }];
	    icon = "https://duckduckgo.com/favicon.ico";
	  };
	};
      };

      extensions.force = true;
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
	ublock-origin
	vimium
	darkreader
      ];
      extensions.settings."uBlock0@raymondhill.net".settings = {
	selectedFilterLists = [
	  "ublock-filters"
	  "ublock-badware"
	  "ublock-privacy"
	  "ublock-quick-fixes"
	  "ublock-unbreak"
	  "easylist-chat"
	  "easylist-newsletters"
	  "easylist-notifications"
	  "easylist-annoyances"
	  "adguard-mobile-app-banners"
	  "adguard-other-annoyances"
	  "adguard-popup-overlays"
	  "adguard-widgets"
	  "ublock-annoyances"
	];
      };

      settings = {
        # middle mouse button don't paste
	"middlemouse.paste" = false;
        # enforce built-in dark theme
	"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        # don't force manual enablement of extensions on first launch
        "extensions.autoDisableScopes" = 0;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.aboutConfig.showWarning" = false;
	"dom.security.https_only_mode" = true;
	"privacy.trackingprotection.enabled" = true;
	"privacy.trackingprotection.pbmode.enabled" = true;
	"privacy.donottrackheader.enabled" = true;
	"signon.rememberSignons" = false;
	"extensions.formautofill.creditCards.enabled" = false;
	"extensions.formautofill.addresses.enabled" = false;
	"browser.urlbar.suggest.quicksuggest.sponsored" = false;
        # hide weather on new tab page
	"browser.newtabpage.activity-stream.showWeather" = false;
	"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
	"browser.newtabpage.activity-stream.feeds.topsites" = false;
	"browser.toolbars.bookmarks.visibility" = "never";
	# set default download dir (to avoid Download dir creation)
	"browser.download.dir" = "/home/john/dl";
	# but don't use it
	"browser.download.useDownloadDir" = false;
	# but actually don't use it
	"browser.download.folderList" = 2;
	"full-screen-api.ignore-widgets" = true;
	"browser.tabs.firefox-view" = false;
	"browser.gesture.swipe.left" = "";
	"browser.gesture.swipe.right" = "";
	"pdfjs.sidebarViewOnLoad" = 0;
	"identity.fxaccounts.enabled" = false;
	"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
	"browser.uitour.enabled" = false;
	"toolkit.telemetry.enabled" = false;
	# prefer dark website content
	"layout.css.prefers-color-scheme.content-override" = 0;
	# don't show about:welcome or privacy page on first launch
	"browser.aboutwelcome.enabled" = false;
	"datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
	# make toolbar slimmer
	"browser.uidensity" = 1;
	# disable pocket
	"extensions.pocket.enabled" = false;
	# keep window open when closing all tabs
	"browser.tabs.closeWindowWithLastTab" = false;
	# allegedly disable addon recommendations
	"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
	# allegedly disable feature recommendations
	"browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
	# make devtools snap to right not bottom
	"devtools.toolbox.host" = "right";
	# don't show "open previous tabs?" toolbar, hopefully still allow functionality
	"browser.startup.couldRestoreSession.count" = -1;
	# allow custom css for theming
	"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
	# customize toolbar
	"browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_8927f234-4dd9-48b1-bf76-44a9e153eee0_-browser-action"],"nav-bar":["back-button","forward-button","vertical-spacer","stop-reload-button","urlbar-container","downloads-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action","reset-pbm-toolbar-button","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","batterdarkerdocs_threethan_github_io-browser-action","addon_darkreader_org-browser-action","unified-extensions-button","_e8ffc3db-2875-4c7f-af38-d03e7f7f8ab9_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button"],"vertical-tabs":[],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","_e8ffc3db-2875-4c7f-af38-d03e7f7f8ab9_-browser-action","batterdarkerdocs_threethan_github_io-browser-action","addon_darkreader_org-browser-action","_8927f234-4dd9-48b1-bf76-44a9e153eee0_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list","vertical-tabs","unified-extensions-area"],"currentVersion":21,"newElementCount":12}'';
      };

      userChrome = builtins.readFile ./firefox/userChrome.css;
      userContent = builtins.readFile ./firefox/userContent.css;

      bookmarks.force = true;
      bookmarks.settings = [
	{
	  name = "google search";
	  url = "https://www.google.com/search?q=%s";
	  keyword = "g";
	}
	{
	  name = "thesaurus search";
	  url = "https://www.wordhippo.com/what-is/another-word-for/%s.html";
	  keyword = "t";
	}
	{
	  name = "youtube search";
	  url = "https://www.youtube.com/results?search_query=%s";
	  keyword = "yt";
	}
	{
	  name = "wikipedia search";
	  url = "https://en.wikipedia.org/wiki/Special:Search?search=%s";
	  keyword = "w";
	}
	{
	  name = "dictionary search";
	  url = "https://www.wordnik.com/words/%s";
	  keyword = "d";
	}
	{
	  name = "github go to repo";
	  url = "https://github.com/johnmpost/%s";
	  keyword = "repo";
	}
	{
	  name = "weekly schedule";
	  url = "https://docs.google.com/spreadsheets/d/1T7pv9OEUOwneCyT_gWwv8L3Ykr2PFgJnjjEycnBEcvU/edit?gid=404477156#gid=404477156";
	  keyword = "wk";
	}
	{
	  name = "snapchat";
	  url = "https://web.snapchat.com";
	  keyword = "snap";
	}
	{
	  name = "wordcount";
	  url = "https://wordcount.com";
	  keyword = "wc";
	}
	{
	  name = "chatgpt";
	  url = "https://chatgpt.com";
	  keyword = "chat";
	}
	{
	  name = "github my repos";
	  url = "https://github.com/johnmpost?tab=repositories";
	  keyword = "repos";
	}
	{
	  name = "github profile";
	  url = "https://github.com/johnmpost";
	  keyword = "gh";
	}
	{
	  name = "monkeytype";
	  url = "https://monkeytype.com";
	  keyword = "type";
	}
	{
	  name = "drive 0";
	  url = "https://drive.google.com/drive/u/0/folders/1hMAgupSZvhAml0K1WhBi9sNINfvkhw0e";
	  keyword = "d0";
	}
	{
	  name = "drive 1";
	  url = "https://drive.google.com/drive/u/1";
	  keyword = "d1";
	}
	{
	  name = "myred";
	  url = "https://myred.nebraska.edu";
	  keyword = "myred";
	}
	{
	  name = "notion calendar";
	  url = "https://www.notion.so/79d6718360ad44b687ff5e8e2679b6fb?v=f21dd02db27241cd8a0c69f7b23adcb7";
	  keyword = "cal";
	}
	{
	  name = "canvas bstrat";
	  url = "https://canvas.unl.edu/courses/191595";
	  keyword = "cbs";
	}
	{
	  name = "canvas bre";
	  url = "https://canvas.unl.edu/courses/191689";
	  keyword = "cbre";
	}
	{
	  name = "canvas network security";
	  url = "https://canvas.unl.edu/courses/188643";
	  keyword = "cns";
	}
	{
	  name = "canvas design studio";
	  url = "https://canvas.unl.edu/courses/188623";
	  keyword = "cds";
	}
	{
	  name = "notion todo";
	  url = "https://www.notion.so/79d6718360ad44b687ff5e8e2679b6fb?v=99054cadfeec433dbcd96790208e3961";
	  keyword = "todo";
	}
	{
	  name = "mail 1";
	  url = "https://mail.google.com/mail/u/1";
	  keyword = "m1";
	}
	{
	  name = "mail 0";
	  url = "https://mail.google.com/mail/u/0";
	  keyword = "m0";
	}
	{
	  name = "mail outlook";
	  url = "https://outlook.office.com/mail/";
	  keyword = "mo";
	}
	{
	  name = "discord";
	  url = "https://discord.com/app";
	  keyword = "dis";
	}
	{
	  name = "downloads";
	  url = "file:///home/john/dl/%s";
	  keyword = "dl";
	}
	{
	  name = "nix package search";
	  url = "https://search.nixos.org/packages?channel=unstable&query=%s";
	  keyword = "nixp";
	}
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  xsession.numlock.enable = true;

  home.file.".config/i3/config".source = ./i3-config;
  home.file.".config/i3/status-config".source = ./i3-status-config;
  home.file.".bashrc".source = ./bashrc;
  home.file.".xinitrc".source = ./xinitrc;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  home.file.".config/picom/picom.conf".source = ./picom.conf;
  home.file.".Xmodmap".source = ./Xmodmap;
  home.file.".config/rclone/rclone.conf".source = ./rclone.conf;

  home.persistence."/nix/persist/home/john" = {
    directories = [
      ".ssh"
      "dl"
      "repos"
      "files"
      ".mozilla/firefox/john/storage/default"
      ".cache/mozilla/firefox/john"
    ];
    files = [
      ".bash_history"
      ".mozilla/firefox/john/places.sqlite"
      ".mozilla/firefox/john/cookies.sqlite"
    ];
    allowOther = true;
  };
}
