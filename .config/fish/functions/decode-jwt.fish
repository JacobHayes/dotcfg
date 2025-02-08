function decode-jwt
    cut -d. -f2 | base64 -d | jq -S '.'
end
