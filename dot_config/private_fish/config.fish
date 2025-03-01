# vim: ft=fish ts=4 sw=4
if status is-interactive
    # Commands to run in interactive sessions can go here

    # EDITOR
    if type -q nvim
        set -gx EDITOR nvim
        set -gx VISUAL nvim
        set -gx DIFFPROG "nvim -d $1"
        set -gx MANPAGER "nvim +Man!"
    end

    # PATH
    fish_add_path --path "$HOME/go/bin"
    fish_add_path --path "$HOME/.local/share/cargo/bin"

    # Include Secrets
    source $ZDOTDIR/.zshrc-secrets

    # Plugins
    # zoxide
    if type -q zoxide
        zoxide init fish | source
    end

    # tide
    tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' \
        --lean_prompt_height='Two lines' --prompt_connection=Dotted \
        --prompt_connection_andor_frame_color=Dark --prompt_spacing=Compact \
        --icons='Few icons' --transient=Yes

    # abbr
    abbr -a ls eza
    function l
        eza -lah --time-style=iso --git --icons=auto $argv
    end
    # abbr -a l 'eza -lah --time-style=iso --git --icons=auto'
    abbr -a df 'duf --hide-mp "/run/credentials/*,/run/user/1000/psd/*"'
    abbr -a lg lazygit
    abbr -a p paru-tmux
    abbr -a n nvim
    abbr -a fm 'xdg-open . >/dev/null 2>&1 & disown'
    # abbr -a fishrc 'nvim ~/.config/fish/config.fish'
    abbr -a zshrc 'nvim ~/.config/zsh/.zshrc'
    abbr -a dg 'sudo downgrade --pacman-cache /mnt/data/.pacman-pkgs/pkg'
    abbr -a kdecs "kdeconnect-cli --device 2ea3fde39bae90a9 --share "
    abbr -a tmpfs 'cd /tmpfs'
    abbr -a --position anywhere cfg ~/.config
    abbr -a chexe 'chmod +x'

    abbr -a screenrec 'wf-recorder -g "$(slurp)" -f $HOME/Videos/screenrecords/"$(date +%Y-%m-%d-%H-%M-%S)".webm -c libvpx-vp9'
    abbr -a screenreca 'wf-recorder -g "$(slurp)" -f $HOME/Videos/screenrecords/"$(date +%Y-%m-%d-%H-%M-%S)".mp4 -c hevc_vaapi -a -d /dev/dri/renderD129'

    # fishrc
    function fishrc
        pushd ~/.config/fish
        nvim ~/.config/fish/config.fish
        popd
    end

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
    if type -q atuin
        atuin init fish --disable-up-arrow | source
    end

    function whichpkg --description "Find the package that owns the command"
        # 如果没有传入参数，则显示用法并退出
        if test (count $argv) -eq 0
            echo "用法：whichpkg <command>"
            return 1
        end

        # command -v 可以获取命令的绝对路径，如果不存在则会返回空
        set -l cmd_path (command -v $argv[1])
        if test -z "$cmd_path"
            echo "错误：无法找到名为 '$argv[1]' 的可执行文件。"
            return 1
        end

        # 使用 pacman -Qo 命令查找此命令所属的包
        pacman -Qo $cmd_path
    end
    complete -c whichpkg -f -w which

    # multicd
    function multicd
        echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end
    abbr --add dotdot --regex '^\.\.+$' --function multicd

    # vi-mode
    # function fish_user_key_bindings
    #     # Execute this once per mode that emacs bindings should be used in
    #     fish_default_key_bindings -M insert
    #
    #     # Then execute the vi-bindings so they take precedence when there's a conflict.
    #     # Without --no-erase fish_vi_key_bindings will default to
    #     # resetting all bindings.
    #     # The argument specifies the initial mode (insert, "default" or visual).
    #     fish_vi_key_bindings --no-erase insert
    # end
    fish_hybrid_key_bindings --no-erase
    bind -M insert ctrl-n down-or-search

    if type -q aichat
        function _aichat_fish
            set -l _old (commandline)
            if test -n $_old
                echo -n "⌛"
                commandline -f repaint
                commandline (aichat -e $_old)
            end
        end
        bind -M insert alt-a _aichat_fish
        bind -M default alt-a _aichat_fish
    end

    function clone --description "git clone something, cd into it."
        git clone --depth=1 $argv[1]
        cd (basename $argv[1] | sed 's/.git$//')
    end

    function md --wraps mkdir -d "Create a directory and cd into it"
        command mkdir -p $argv
        if test $status = 0
            switch $argv[(count $argv)]
                case '-*'
                case '*'
                    cd $argv[(count $argv)]
                    return
            end
        end
    end

end
