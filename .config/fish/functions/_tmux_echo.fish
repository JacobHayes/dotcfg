function _tmux_echo
  if set -q TMUX
    echo -e "\033Ptmux;\033$argv\033\\"
  else
    echo -e $argv
  end
end
