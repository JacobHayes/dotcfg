function _set_theme
    switch $argv
        case light
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
        case dark
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
    end
end
