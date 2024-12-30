function conflictvim
    nvim +"/\\v(HEAD|Updated upstream)" (git diff --name-only --diff-filter=U)
end
