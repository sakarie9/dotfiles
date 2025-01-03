function cpv
    rsync -pogbr -hhh --backup-dir="/tmp/rsync-$USERNAME" -e /dev/null --progress "$argv"
end

complete -c cpv -a "(_files)"
