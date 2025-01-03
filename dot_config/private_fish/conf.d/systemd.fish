# systemctl abbr for user commands
set -l user_commands cat get-default help is-active is-enabled is-failed is-system-running list-dependencies list-jobs list-sockets list-timers list-unit-files list-units show show-environment status

# systemctl abbr for sudo commands
set -l sudo_commands add-requires add-wants cancel daemon-reexec daemon-reload default disable edit emergency enable halt import-environment isolate kexec kill link list-machines load mask preset preset-all reenable reload reload-or-restart reset-failed rescue restart revert set-default set-environment set-property start stop switch-root try-reload-or-restart try-restart unmask unset-environment

# systemctl abbr for power commands
set -l power_commands hibernate hybrid-sleep poweroff reboot suspend

# Set user commands abbr
for c in $user_commands
    abbr -a "sc-$c" "systemctl $c"
    abbr -a "scu-$c" "systemctl --user $c"
end

# Set sudo commands abbr
for c in $sudo_commands
    abbr -a "sc-$c" "sudo systemctl $c"
    abbr -a "scu-$c" "systemctl --user $c"
end

# Set power commands abbr
for c in $power_commands
    abbr -a "sc-$c" "systemctl $c"
end

# --now commands
abbr -a sc-enable-now "sc-enable --now"
abbr -a sc-disable-now "sc-disable --now"
abbr -a sc-mask-now "sc-mask --now"

abbr -a scu-enable-now "scu-enable --now"
abbr -a scu-disable-now "scu-disable --now"
abbr -a scu-mask-now "scu-mask --now"

# --failed commands
abbr -a scu-failed 'systemctl --user --failed'
abbr -a sc-failed 'systemctl --failed'

# Function to show systemd prompt info
function systemd_prompt_info
    for unit in $argv
        echo -n "$ZSH_THEME_SYSTEMD_PROMPT_PREFIX"

        if test -n "$ZSH_THEME_SYSTEMD_PROMPT_CAPS"
            echo -n (string upper $unit | string replace '%' '%%')":"
        else
            echo -n (string replace '%' '%%' $unit)":"
        end

        if systemctl is-active $unit ^/dev/null
            echo -n "$ZSH_THEME_SYSTEMD_PROMPT_ACTIVE"
        else if systemctl --user is-active $unit ^/dev/null
            echo -n "$ZSH_THEME_SYSTEMD_PROMPT_ACTIVE"
        else
            echo -n "$ZSH_THEME_SYSTEMD_PROMPT_NOTACTIVE"
        end

        echo -n "$ZSH_THEME_SYSTEMD_PROMPT_SUFFIX"
    end
end
