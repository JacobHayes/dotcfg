set ignore-comments	:= true

NIX_DIR := '.config/nix/'

# Build and activate the current configuration.
nix-apply ARGS="":
    darwin-rebuild switch --flake "{{NIX_DIR}}" {{ARGS}}
    # Set default shell, until this is resolved: https://github.com/LnL7/nix-darwin/issues/1237
    if [[ "$SHELL" != *fish* ]]; then chsh -s /run/current-system/sw/bin/fish; fi

nix-update:
    nix flake update --flake "{{NIX_DIR}}"
    just nix-apply

diff-plists:
  echo "Reading current settings..."
  defaults read >/tmp/settings-before.txt
  read -r -p "Toggle your setting and press any key..."
  echo "Reading updated settings..."
  defaults read >/tmp/settings-after.txt
  nvim -d /tmp/settings-before.txt /tmp/settings-after.txt
  rm /tmp/settings-before.txt /tmp/settings-after.txt
