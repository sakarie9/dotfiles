# systemctl abbr for user commands
set -l user_commands cat get-default help is-active is-enabled is-failed is-system-running list-dependencies list-jobs list-sockets list-timers list-unit-files list-units show show-environment status

# systemctl abbr for sudo commands
set -l sudo_commands add-requires add-wants cancel daemon-reexec daemon-reload default disable edit emergency enable halt import-environment isolate kexec kill link list-machines load mask preset preset-all reenable reload reload-or-restart reset-failed rescue restart revert set-default set-environment set-property start stop switch-root try-reload-or-restart try-restart unmask unset-environment

# systemctl abbr for power commands
set -l power_commands hibernate hybrid-sleep poweroff reboot suspend

# Set user commands abbr
for c in $user_commands
    alias "sc-$c" "systemctl $c"
    alias "scu-$c" "systemctl --user $c"
end

# Set sudo commands abbr
for c in $sudo_commands
    alias "sc-$c" "sudo systemctl $c"
    alias "scu-$c" "systemctl --user $c"
end

# Set power commands abbr
for c in $power_commands
    alias "sc-$c" "systemctl $c"
end

# --now commands
alias sc-enable-now "sc-enable --now"
alias sc-disable-now "sc-disable --now"
alias sc-mask-now "sc-mask --now"

alias scu-enable-now "scu-enable --now"
alias scu-disable-now "scu-disable --now"
alias scu-mask-now "scu-mask --now"

# --failed commands
alias scu-failed 'systemctl --user --failed'
alias sc-failed 'systemctl --failed'
