# nix-darwin configuration
#
# https://daiderd.com/nix-darwin/manual/index.html
{ inputs, nix-homebrew, pkgs, ... }: {
  environment = {
    shells = [ pkgs.fish ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.monaspace
  ];

  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      # cleanup = "zap"; # TODO: Uncomment on new computer
      upgrade = true;
    };

    taps = [
      "1password/tap"
      "johanhaleby/kubetail"
    ];
    casks = [
      # "1password"
      # "calibre"
      "chatgpt"
      # "cold-turkey-blocker"
      "ghostty"
      # "google-chrome"
      "microsoft-teams"
      # "obsidian"
      "orbstack"
      "postico"
      # "raycast"
      # "reader"
      "rectangle"
      # "signal"
      # "slack"
      # "spotify"
      #
      # Not needed anymore(?):
      #
      # "alfred"
      # "anki"
      # "docker"
      # "font-monaspace"
      # "font-monaspace-nerd-font"
      # "karabiner-elements"
      # "logitune" # NOTE: This just downloads the installer, which must still be run manually
      # "macwhisper"
      # "monitorcontrol"
      # "vitamin-r"
      # "zwift"
    ];
    masApps = { # IDs can be found on the share links from the App Store
      "1Password for Safari" = 1569813296;
      # "Actions for Obsidian" = 1659667937;
      # "Actions" = 1586435171;
      "Dark Reader for Safari" = 1438243180;
      # "Data Jar" = 1453273600;
      # "Save to Reader" = 1640236961;
      "Tailscale" = 1475387142;
      "Vimari" = 1480933944;
      # "Xcode" = 497799835;
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true; # Allow non-OSI licenses (eg: BSL for Terraform)

  nix = {
    channel.enable = false;
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
    optimise.automatic = true; # Optimize the store occasionally
    settings = {
      experimental-features = [ "flakes" "nix-command" ];
      use-xdg-base-directories = true; # Use ~/.config/nix instead of home
    };
    useDaemon = true;
  };

  nix-homebrew = {
    # enable = true; # TODO: Uncomment on new computer
    user = "jacobhayes";
  };

  programs = {
    fish.enable = true;
  };

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null; # Set Git commit hash for darwin-version.
    # TODO: Look into additional system settings to configure.
    defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      finder.FXPreferredViewStyle = "clmv";
    };
    stateVersion = 5; # Used for backwards compatibility - before changing, read: `darwin-rebuild changelog`
  };

  users.users.jacobhayes.shell = pkgs.fish;
}
