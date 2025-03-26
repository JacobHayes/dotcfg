function gclone
    # ex: pandas-dev/pandas
    mkdir -p ~/src/github.com/(dirname $argv)
    jj git clone --colocate git@github.com:$argv.git ~/src/github.com/$argv
    cd ~/src/github.com/$argv
end
