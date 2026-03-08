if status is-interactive
    # Disable welcome message
    set fish_greeting ""

    # Fastfetch on startup
    fastfetch

    # Oh My Posh - M365Princess Theme
    oh-my-posh init fish --config /usr/share/oh-my-posh/themes/M365Princess.omp.json | source

    # Direnv + Zoxide
    command -v direnv &> /dev/null && direnv hook fish | source
    command -v zoxide &> /dev/null && zoxide init fish --cmd cd | source

    # Better ls
    alias ls='eza --icons --group-directories-first'
    alias ll='ls -l'
    alias la='ls -la'
    alias lla='ls -la'

    # Gammastep preset switcher
    alias gsset='~/.config/hypr/scripts/gammastep-preset.sh'

    # Caelestia restart (handles zombie instances)
    alias caer='caelestia shell -k 2>/dev/null; sleep 1; caelestia shell -d'

    # Git abbreviations
    abbr g git
    abbr gs git status
    abbr ga git add
    abbr gc git commit
    abbr gp git push
    abbr gl git log
    abbr gd git diff
    abbr gst git stash
    abbr lg lazygit

    # System
    abbr update 'sudo pacman -Syu'
    abbr clean 'sudo pacman -Rns $(pacman -Qtdq)'
    abbr ports 'ss -tulanp'

    # Custom colours
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end
end
set -gx PATH /opt/cuda/bin $PATH
set -gx PATH /opt/cuda/bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.local/flutter/bin $PATH
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx ANDROID_SDK_ROOT $HOME/Android/Sdk
