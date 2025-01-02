if string match -q -- '*ghostty*' $TERM
    set -g fish_vi_force_cursor 1

    source "$GHOSTTY_RESOURCES_DIR/../fish/vendor_completions.d/ghostty.fish"
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end
