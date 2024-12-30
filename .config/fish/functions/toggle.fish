function toggle
    # If the current setting is dark, this command returns "Dark". Otherwise, the field is missing and errors.
    if defaults read -g AppleInterfaceStyle >/dev/null 2>&1
        light
    else
        dark
    end
end

