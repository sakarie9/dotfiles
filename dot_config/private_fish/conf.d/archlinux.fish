# Pacman
abbr -a pacupg 'sudo pacman -Syu'
abbr -a pacin 'sudo pacman -S'
abbr -a paclean 'sudo pacman -Sc'
abbr -a pacins 'sudo pacman -U'
abbr -a paclr 'sudo pacman -Scc'
abbr -a pacre 'sudo pacman -R'
abbr -a pacrem 'sudo pacman -Rns'
abbr -a pacrep 'pacman -Si'
abbr -a pacreps 'pacman -Ss'
abbr -a pacloc 'pacman -Qi'
abbr -a paclocs 'pacman -Qs'
abbr -a pacinsd 'sudo pacman -S --asdeps'
abbr -a pacmir 'sudo pacman -Syy'
abbr -a paclsorphans 'sudo pacman -Qdt'
abbr -a pacrmorphans 'sudo pacman -Rs $(pacman -Qtdq)'
abbr -a pacfileupg 'sudo pacman -Fy'
abbr -a pacfiles 'pacman -F'
abbr -a pacls 'pacman -Ql'
abbr -a pacown 'pacman -Qo'
abbr -a pacupd "sudo pacman -Sy"

function paclist
    pacman -Qqe | xargs -I{} -P0 --no-run-if-empty pacman -Qs --color=auto "^{}\$"
end

function pacdisowned
    set tmp_dir $(mktemp --directory)
    set db $tmp_dir/db
    set fs $tmp_dir/fs

    trap "rm -rf $tmp_dir" EXIT

    pacman -Qlq | sort -u >"$db"

    find /etc /usr ! -name lost+found \
        \( -type d -printf '%p/\n' -o -print \) | sort >"$fs"

    comm -23 "$fs" "$db"

    rm -rf $tmp_dir
end

abbr -a pacmanallkeys 'sudo pacman-key --refresh-keys'

function pacmansignkeys
    for key in $argv
        do
        sudo pacman-key --recv-keys $key
        sudo pacman-key --lsign-key $key
        printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg \
            --no-permission-warning --command-fd 0 --edit-key $key
        done
    end
end

if type -q xdg-open
    function pacweb
        if test (count $argv) -eq 0 -o "$argv[1]" = --help -o "$argv[1]" = -h
            set underline_color (set_color -u)
            echo "$_ - open the website of an ArchLinux package"
            echo
            echo "Usage:"
            echo "    $bold_color$_$reset_color $underline_color""target$reset_color"
            return 1
        end

        set pkg "$argv[1]"
        set infos (LANG=C pacman -Si "$pkg")
        if test -z "$infos"
            return
        end
        set repo (echo "$infos" | grep -m 1 '^Repo' | grep -oP '[^ ]+$')
        set arch (echo "$infos" | grep -m 1 '^Arch' | grep -oP '[^ ]+$')
        xdg-open "https://www.archlinux.org/packages/$repo/$arch/$pkg/" &>/dev/null
    end
end

if type -q paru
    abbr -a paclean 'paru -Sc'
    abbr -a paclr 'paru -Scc'
    abbr -a paupg 'paru -Syu'
    abbr -a pasu 'paru -Syu --noconfirm'
    abbr -a pain 'paru -S'
    abbr -a pains 'paru -U'
    abbr -a pare 'paru -R'
    abbr -a parem 'paru -Rns'
    abbr -a parep 'paru -Si'
    abbr -a pareps 'paru -Ss'
    abbr -a paloc 'paru -Qi'
    abbr -a palocs 'paru -Qs'
    abbr -a palst 'paru -Qe'
    abbr -a paorph 'paru -Qtd'
    abbr -a painsd 'paru -S --asdeps'
    abbr -a pamir 'paru -Syy'
    abbr -a paupd 'paru -Sy'
    abbr -a upgrade 'paru -Syu'
end
