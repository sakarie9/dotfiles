# vim: ft=fish ts=4 sw=4
if status is-interactive
    # Commands to run in interactive sessions can go here

    # EDITOR
    set -gx EDITOR nvim
    set -gx DIFFPROG "nvim -d $1"

    # PATH
    fish_add_path "~/go/bin"
    fish_add_path "~/.local/share/cargo/bin"

    # Include Secrets
    source $ZDOTDIR/.zshrc-secrets

    # Plugins
    # zoxide
    zoxide init fish | source

    # tide
    tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' \
        --lean_prompt_height='Two lines' --prompt_connection=Dotted \
        --prompt_connection_andor_frame_color=Dark --prompt_spacing=Compact \
        --icons='Few icons' --transient=Yes

    # abbr
    abbr -a ls eza
    abbr -a l 'eza -lah --time-style=iso --git --icons=auto'
    abbr -a df 'duf --hide-mp "/run/credentials/*,/run/user/1000/psd/*"'
    abbr -a lg lazygit
    abbr -a p paru-tmux
    abbr -a n nvim
    abbr -a fm 'xdg-open . >/dev/null 2>&1 & disown'
    abbr -a fishrc 'nvim ~/.config/fish/config.fish'
    abbr -a dg 'sudo downgrade --pacman-cache /mnt/data/.pacman-pkgs/pkg'
    abbr -a kdecs "kdeconnect-cli --device 2ea3fde39bae90a9 --share "
    abbr -a tmpfs 'cd /tmpfs'
    abbr -a --position anywhere cfg ~/.config

    # plugins from zsh
    abbr -a dcup docker compose up
    abbr -a dcupd docker compose up -d
    abbr -a dcdn docker compose down
    abbr -a dcl docker compose logs
    abbr -a dclf docker compose logs -f
    abbr -a dclF docker compose logs -f --tail 0

    # yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # atuin
    atuin init fish --disable-up-arrow | source

    # multicd
    function multicd
        echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end
    abbr --add dotdot --regex '^\.\.+$' --function multicd

    # vi-mode
    function fish_user_key_bindings
        # Execute this once per mode that emacs bindings should be used in
        fish_default_key_bindings -M insert

        # Then execute the vi-bindings so they take precedence when there's a conflict.
        # Without --no-erase fish_vi_key_bindings will default to
        # resetting all bindings.
        # The argument specifies the initial mode (insert, "default" or visual).
        fish_vi_key_bindings --no-erase insert
    end

end
