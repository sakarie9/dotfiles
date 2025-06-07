# Define the gi function to fetch .gitignore files
function gi
    curl -fLw '\n' https://www.toptal.com/developers/gitignore/api/(string join , $argv) >.gitignore
end

# Fetch the list of available .gitignore templates
function _gitignoreio_get_command_list
    curl -sfL https://www.toptal.com/developers/gitignore/api/list | tr "," "\n"
end

# Define a function to provide completions for gi
function _gitignoreio
    set -l templates (_gitignoreio_get_command_list)
    for template in $templates
        echo $template
    end
end

# Register the completion function for gi
complete -c gi -a "(_gitignoreio)"
