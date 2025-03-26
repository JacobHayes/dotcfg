# Home Manager configuration
#
# https://nix-community.github.io/home-manager/options.xhtml
{
  config,
  pkgs,
  lib,
  ...
}:
{
  home = {
    homeDirectory = lib.mkForce "/Users/jacobhayes"; # https://github.com/nix-community/home-manager/issues/6036#issuecomment-2506160086
    packages = with pkgs; [
      # TODO: Consider paring these down and prefer per-project packages (eg: make, uv, etc).
      _1password-cli
      bash
      bat
      cachix
      chafa
      coreutils
      ctags
      curl
      delta
      diffutils
      duckdb
      exiftool
      fd
      fzf
      gh
      git
      gnumake
      gnupg
      gnused
      gnutar
      go
      (google-cloud-sdk.withExtraComponents [
        google-cloud-sdk.components.bq
        google-cloud-sdk.components.cloud-sql-proxy
        google-cloud-sdk.components.gke-gcloud-auth-plugin
      ])
      graphviz
      gzip
      hyperfine
      jq
      jujutsu
      just
      kubectl
      kubetail
      kustomize
      less
      luajit
      luarocks
      ncurses # Pull a newer version of infocmp to export ghostty terminfo
      nixfmt-rfc-style
      nodejs_23
      nvd
      openssh
      postgresql
      ripgrep
      rye
      sqlite-interactive
      terraform
      tmux
      tree
      uv
      watch
      yq
      zip
    ];
    sessionPath = [
      "$HOME/.cargo/bin"
      "$HOME/.local/bin"
      "$HOME/bin"
      "/Applications/Tailscale.app/Contents/MacOS"
    ];
    sessionVariables = {
      COPYFILE_DISABLE = "1"; # Turn off special handling of ._* files in tar, etc.
      GOPATH = "$HOME";
      JJ_CONFIG = "${config.xdg.configHome}/jj/config.toml";
      LESS = "-FRS"; # Don't page if <1 screen, show colors, don't wrap
      PYTHONDONTWRITEBYTECODE = "1";
      RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgreprc";
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      TMPDIR = "/tmp"; # Override defaults to "/var/folders/..."
    };
    shellAliases = {
      cfg = "git --git-dir=$HOME/.dotcfg --work-tree=$HOME";
      fd = "fd --hidden";
      fp = "realpath";
      g = "git";
      reload = "exec $SHELL";
    };
    stateVersion = "24.11";
    username = "jacobhayes";
  };

  # TODO: Determine whether I really want to 1) manage config files with nix
  # modules directly (which may have limitations), or 2) just have nix
  # copy/link static files over, or 3) manage them completely externally.
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true; # Automatically cache envs: https://github.com/nix-community/nix-direnv
    };
    eza = {
      enable = true;
      extraOptions = [
        "--all"
        "--git"
        "--group-directories-first"
        "--header"
        "--icons"
        "--sort=Name" # [A, B, a]; not [A, a, B]
      ];
    };
    fish = {
      enable = true;
      plugins = [
        # NOTE: When changing revisions, we need to update the hash to actually trigger a check.
        {
          name = "done";
          src = pkgs.fetchFromGitHub {
            owner = "franciscolourenco";
            repo = "done";
            rev = "1.19.3";
            sha256 = "DMIRKRAVOn7YEnuAtz4hIxrU93ULxNoQhW6juxCoh4o=";
          };
        }
        {
          name = "fish-command-timer";
          src = pkgs.fetchFromGitHub {
            owner = "JacobHayes";
            repo = "fish-command-timer";
            rev = "81bc73cf67b48985515c10be4f01e3a9e81b21e6";
            sha256 = "INJOFtlS4IU+mdBih9xyG/qV7DkrJVPSIzS8UIqvHME=";
          };
        }
      ];
    };
    home-manager.enable = true;
    neovim = {
      defaultEditor = true;
      enable = true;
      extraPython3Packages = ps: with ps; [ pynvim ];
      withNodeJs = false;
      withPython3 = true;
      withRuby = false;
    };
    zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };

  xdg.enable = true; # Set XDG_* env vars
}
