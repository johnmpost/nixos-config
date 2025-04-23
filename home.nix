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
    hledger
    xclip
    nodejs_23
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
  ];

  programs = {
    home-manager.enable = true;
  };

  programs.nixvim = {
    enable = true;
    opts = {
      number = true;
      shiftwidth = 2;
      ignorecase = true;
      smartcase = true;
    };

    colorschemes.vscode = {
      enable = true;
      settings = {
        group_overrides = {
	  Comment = { fg = "#5A5A5A"; bg = "NONE"; };
	};
      };
    };

    plugins = {
      web-devicons.enable = true;
      nvim-surround.enable = true;
      nvim-autopairs.enable = true;
      lualine = {
        enable = true;
	settings.options.disabled_filetypes = [ "NvimTree" ];
      };
      nvim-tree = {
        enable = true;       
	renderer.rootFolderLabel = false;
	hijackCursor = true;
      };
      telescope.enable = true;
      bufferline = {
        enable = true;
	settings.highlights.buffer_selected.italic = false;
	settings.highlights.buffer_selected.bold = false;
	settings.options = {
	  show_buffer_close_icons = false;
	  offsets = [{
	    filetype = "NvimTree";
	    text = "Files";
	    highlight = "Directory";
	    separator = true;
	  }];
	  persist_buffer_sort = false;
	  separator_style = "thin";
	};
      };
    };

    globals.mapleader = " ";
    keymaps = [
    {
      key = ";";
      action = ":";
    }
    {
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<CR>";
      options.silent = true;
    }
    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.silent = true;
    }
    # TODO fix double map
    {
      key = "<leader>fg";
      action = "<cmd>Telescope git_files<CR>";
      options.silent = true;
    }
    {
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options.silent = true;
    }
    {
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.silent = true;
    }
    {
      key = "<leader>fw";
      action = "<cmd>Telescope grep_word<CR>";
      options.silent = true;
    }
    {
      key = "<leader>s";
      action = "<cmd>w<CR>";
      options.silent = true;
    }
    {
      key = "<leader>x";
      action = "<cmd>bd<CR>";
      options.silent = true;
    }
    {
      key = "<leader>r";
      action = "<cmd>Telescope oldfiles cwd_only=true<CR>";
      options.silent = true;
    }
    # TODO bufferline reorder buffers
    # TODO bufferline make separator a color and nice
    # TODO bufferline LSP feedback
    ] ++ 
    (let
      keys = [1 2 3 4 5 6];
    in
    map (i: {
      key = "<A-${toString i}>";
      action = "<cmd>lua require('bufferline').go_to(${toString i}, true)<CR>";
      options.silent = true;
    }) keys);
  };

  programs.firefox = {
    enable = true;
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
	  ddgc = {
	    name = "DuckDuckGo (themed)";
	    urls = [{ template = "https://duckduckgo.com/?k7=222222&kj=222222&kae=d&q={searchTerms}"; }];
	    icon = "https://duckduckgo.com/favicon.ico";
	    definedAliases = [ "d" ];
	  };
	};
      };
      settings = {
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.aboutConfig.showWarning" = false;
	"dom.security.https_only_mode" = true;
	"privacy.trackingprotection.enabled" = true;
	"privacy.trackingprotection.pbmode.enabled" = true;
	"privacy.donottrackheader.enabled" = true;
	"privacy.resistFingerprinting" = true;
	"signon.rememberSignons" = false;
	"extensions.formautofill.creditCards.enabled" = false;
	"extensions.formautofill.addresses.enabled" = false;
	"browser.urlbar.suggest.quicksuggest.sponsored" = false;
	"browser.newtabpage.activity-stream.feeds.section.topstories" = false;
	"browser.newtabpage.activity-stream.feeds.topsites" = false;
	"browser.toolbars.bookmarks.visibility" = "never";
	"browser.download.useDownloadDir" = false;
	"full-screen-api.ignore-widgets" = true;
	"browser.tabs.firefox-view" = false;
	"browser.gesture.swipe.left" = false;
	"browser.gesture.swipe.right" = false;
	"pdfjs.sidebarViewOnLoad" = 0;
	"identity.fxaccounts.enabled" = false;
	"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
	"browser.uitour.enabled" = false;
	"toolkit.telemetry.enabled" = false;
	# prefer dark website content
	"layout.css.prefers-color-scheme.content-override" = 0;
      };
      bookmarks.force = true;
      bookmarks.settings = [
	{
	  name = "wordhippo";
	  url = "https://www.wordhippo.com/";
	  keyword = "wh";
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
	  name = "youtube search";
	  url = "https://www.youtube.com/results?search_query=%s";
	  keyword = "yt";
	}
	{
	  name = "chatgpt";
	  url = "https://chatgpt.com";
	  keyword = "chat";
	}
	{
	  name = "github repos";
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
	  keyword = "drive0";
	}
	{
	  name = "drive 1";
	  url = "https://drive.google.com/drive/u/1";
	  keyword = "drive1";
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
	  keyword = "mail1";
	}
	{
	  name = "mail 0";
	  url = "https://mail.google.com/mail/u/0";
	  keyword = "mail0";
	}
	{
	  name = "mail outlook";
	  url = "https://outlook.office.com/mail/";
	  keyword = "mailo";
	}
	{
	  name = "discord";
	  url = "https://discord.com/app";
	  keyword = "dis";
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

  home.file.".config/i3/config".source = ./i3-config;
  home.file.".config/i3/status-config".source = ./i3-status-config;
  home.file.".bashrc".source = ./bashrc;
  home.file.".xinitrc".source = ./xinitrc;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  home.file.".config/picom/picom.conf".source = ./picom.conf;
  home.file.".Xmodmap".source = ./Xmodmap;

  home.persistence."/nix/persist/home/john" = {
    directories = [
      ".ssh"
      "dl"
      "repos"
      ".mozilla/firefox/john/storage/default"
    ];
    files = [
      ".bash_history"
      ".mozilla/firefox/john/places.sqlite"
      ".mozilla/firefox/john/cookies.sqlite"
    ];
    allowOther = true;
  };
}
