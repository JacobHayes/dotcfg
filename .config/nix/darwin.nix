# nix-darwin configuration
#
# https://daiderd.com/nix-darwin/manual/index.html
{
  hostname,
  inputs,
  pkgs,
  ...
}:
{
  environment = {
    shells = [ pkgs.fish ];
  };

  fonts.packages = with pkgs; [
    monaspace
  ];

  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "1password/tap"
    ];
    casks = [
      "1password"
      "calibre"
      "chatgpt"
      "cold-turkey-blocker"
      "cursor"
      "ghostty"
      "google-chrome"
      "homerow"
      "monitorcontrol"
      "obsidian"
      "orbstack"
      "postico"
      "raycast"
      "rectangle"
      "slack"
      "spotify"
      "tailscale-app"
      "tuple"
      "utm"
      "zoom"
    ];
    masApps = {
      # IDs can be found on the share links from the App Store
      "1Password for Safari" = 1569813296;
      "Actions for Obsidian" = 1659667937;
      "Actions" = 1586435171;
      "Dark Reader for Safari" = 1438243180;
      "Data Jar" = 1453273600;
      "Obsidian Web Clipper" = 6720708363;
      "Xcode" = 497799835;
    };
  };

  networking.hostName = hostname;

  nixpkgs = {
    config.allowUnfree = true; # Allow non-OSI licenses (eg: BSL for Terraform)
    hostPlatform = "aarch64-darwin";
  };

  nix = {
    channel.enable = false;
    enable = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    # NOTE: The store optimization causes code signing / syspolicyd issues, causing system freezes:
    # https://github.com/nix-darwin/nix-darwin/issues/1307
    optimise.automatic = false;
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      use-xdg-base-directories = true; # Use ~/.config/nix instead of home
    };
  };

  nix-homebrew = {
    enable = true;
    user = "jacobhayes";
  };

  programs = {
    fish.enable = true;
    # Opening a terminal when the nix env is broken can fail in ways that make debugging difficult.
    # To ensure we have an escape hatch, we disable the default bash/nix configuration and configure
    # Terminal.app to use /bin/bash (see below).
    zsh.enable = false;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    primaryUser = "jacobhayes";

    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    defaults = {
      NSGlobalDomain = {
        "com.apple.springing.delay" = .5;
        "com.apple.springing.enabled" = true;
        "com.apple.trackpad.scaling" = 1.5;
        AppleICUForce24HourTime = true;
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        ApplePressAndHoldEnabled = false; # Allow key repeat (eg: vim nav)
        AppleScrollerPagingBehavior = true;
        AppleTemperatureUnit = "Celsius";
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSWindowResizeTime = 0.0;
      };
      controlcenter.BatteryShowPercentage = true;
      controlcenter.Bluetooth = true;
      dock = {
        autohide = true;
        expose-group-apps = true;
        mru-spaces = false;
        persistent-apps = [
          "/Applications/Ghostty.app"
          "/Applications/Safari.app"
          "/Applications/Spotify.app"
        ];
        persistent-others = [ ];
        show-process-indicators = true;
        show-recents = false;
        wvous-tr-corner = 13; # Lock screen
        wvous-tl-corner = 1; # Disabled
        wvous-bl-corner = 1; # Disabled
        wvous-br-corner = 14; # Open quick note
      };
      finder = {
        "_FXSortFoldersFirst" = true;
        "_FXSortFoldersFirstOnDesktop" = true;
        FXDefaultSearchScope = "SCev";
        FXPreferredViewStyle = "clmv";
        FXRemoveOldTrashItems = true;
        NewWindowTarget = "Home";
        ShowMountedServersOnDesktop = true;
        ShowPathbar = true;
      };
      WindowManager = {
        AppWindowGroupingBehavior = true;
        EnableTiledWindowMargins = false;
      };
      # NOTE: Not all settings have direct integrations, but can still be overridden (without validation):
      CustomUserPreferences = {
        NSGlobalDomain = {
          AppleFirstWeekday = {
            gregorian = 2;
          };
          AppleICUDateFormatStrings = {
            "1" = "y-MM-dd";
          };
        };
        "com.apple.dock" = {
          showAppExposeGestureEnabled = true;
        };
        "com.apple.finder" = {
          DesktopViewSettings = {
            GroupBy = "Kind";
            IconViewSettings = {
              arrangeBy = "name";
              showItemInfo = 1;
            };
          };
          FXICloudDriveDesktop = 1; # NOTE: This may not work without FXDetachedDesktopProviderID, but that contains a UUID
          FXICloudDriveDocuments = 1; # NOTE: This may not work without FXDetachedDocumentsProviderID, but that contains a UUID
          FXPreferredGroupBy = "Kind";
          SidebarShowingiCloudDesktop = 1;
          SidebarTagsSctionDisclosedState = 1;
        };
        "com.apple.Safari" = {
          AlwaysRestoreSessionAtLaunch = true;
          AutoOpenSafeDownloads = false;
          ExcludePrivateWindowWhenRestoringSessionAtLaunch = false;
          IncludeDevelopMenu = true;
          OpenPrivateWindowWhenNotRestoringSessionAtLaunch = false;
          ShowFullURLInSmartSearchField = true;
          ShowOverlayStatusBar = true;
          ShowStandaloneTabBar = false; # Prefer compact tabs
          WBSNewBlankTabPositionAppliesToAllBlankTabsPreferenceKey = true; # Open new tabs to the right of the current tab
          WBSNewTabPositionPreferenceKey = false; # Open new tabs to the right of the current tab
          # Prefer 1Password over the builtin autofill
          AutoFillCreditCardData = false;
          AutoFillFromAddressBook = false;
          AutoFillMiscellaneousForms = false;
          AutoFillPasswords = false;
        };
        "com.apple.Terminal" = {
          Shell = "/bin/zsh"; # Override the default (fish+nix) login shell to ensure we start with a minimal state.
        };
        "com.openai.chat" = {
          desktopAppIconBehavior = "{\"showOnlyInMenuBar\":{}}";
          launchAtLogin = true;
          launcherOpenPosition = "{\"specific\":{\"_0\":{\"bottomRight\":{}}}}";
        };
        "com.superultra.Homerow" = {
          "launch-at-login" = 1;
          "non-search-shortcut" = "\\u2303F";
          "scroll-shortcut" = "\\u2325J";
          "show-menubar-icon" = 0;
        };
        # OrbStack
        "dev.kdrag0n.MacVirt" = {
          global_showMenubarExtra = false;
          global_stayInBackground2 = true;
          SUAutomaticallyUpdate = true;
        };
      };
    };
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;
    stateVersion = 5; # Used for backwards compatibility - before changing, read: `darwin-rebuild changelog`
  };

  users.users.jacobhayes.shell = pkgs.fish;
}
