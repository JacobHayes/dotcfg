function _set_theme
    switch $argv
        case light
            claude config set -g theme light
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" >/dev/null
        case dark
            claude config set -g theme dark
            osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" >/dev/null
    end
end
