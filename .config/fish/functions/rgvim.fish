function rgvim --wraps rg
    nvim +"/\v$argv[1]" (rg -l -- $argv | sort | uniq)
end
