function zk
    set --local prefix ""

    if test "$argv[1]" = --date
        set prefix "$(date --iso=d) - "
        set --erase argv[1]
    end

    if test -z "$argv"
        echo "Please provide a title for the note."
        return 1
    end

    set note_name "$prefix$argv"
    set note "$HOME/Obsidian/Personal/zk/$note_name.md"

    if ! test -f "$note"
        cp "$HOME/Obsidian/Personal/zk/_template.md" "$note"
    end

    echo "$note"
    nvim "$note"
end
