function _set_profile
    echo "Setting macos..."
    switch $argv
        case light
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
        case dark
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
    end

    echo "Setting neovim"
    sed -i "s/background = \".*\"/background = \"$argv\"/" ~/.config/nvim/lua/config/options.lua

    echo "Setting tmux..."
    sed -i --follow-symlinks "s#set -g @tmux-gruvbox '.*'#set -g @tmux-gruvbox '$argv'#" ~/.tmux.conf
    tmux source-file ~/.tmux.conf

    echo "Setting delta..."
    switch $argv
        case light
            sed -i \
                -e 's/^  dark = true/  ; dark = true/' \
                -e 's/^  ; light = true/  light = true/' \
                -e 's/^  syntax-theme = gruvbox-dark/  syntax-theme = gruvbox-light/' \
                ~/.gitconfig
        case dark
            sed -i \
                -e 's/^  ; dark = true/  dark = true/' \
                -e 's/^  light = true/  ; light = true/' \
                -e 's/^  syntax-theme = gruvbox-light/  syntax-theme = gruvbox-dark/' \
                ~/.gitconfig
    end
end
