set fish_greeting ""
set fish_key_bindings fish_vi_key_bindings

if string match -q -- '*ghostty*' $TERM
    set -g fish_vi_force_cursor 1
end
