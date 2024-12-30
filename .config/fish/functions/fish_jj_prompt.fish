# Modified from https://gist.github.com/hroi/d0dc0e95221af858ee129fd66251897e
function fish_jj_prompt --description 'Write out the jj prompt'
    if not command -sq jj
        return 1
    end

    if not jj root --quiet &>/dev/null
        return 1
    end

    # NOTE: Add `--ignore-working-copy` if this makes prompts slow or causes other issues
    jj log --no-graph --color always -r @ -T '
        surround(
            " (",
            ")",
            separate(
                " ",
                change_id.shortest(6),
                bookmarks.join(", "),
                coalesce(
                    surround(
                        "[",
                        "]",
                        if(
                            description.first_line().substr(0, 24).starts_with(description.first_line()),
                            description.first_line().substr(0, 24),
                            description.first_line().substr(0, 23) ++ "…"
                        )
                    ),
                    "[untitled]"
                ),
                if(conflict, "(conflict)"),
                if(empty, "(empty)"),
                if(divergent, "(divergent)"),
                if(hidden, "(hidden)"),
            )
        )
    '
end
