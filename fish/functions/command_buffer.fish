function edit_command_buffer --description 'Edit the command buffer in an external editor'
    set -l f (mktemp)
    if set -q f[1]
        mv $f $f
        set f $f
    else
        # We should never execute this block but better to be paranoid.
        set f /tmp/fish.(echo %self)
        touch $f
    end

    set -l p (commandline -C)
    commandline -b > $f
    if set -q EDITOR
        eval $EDITOR $f +\"set ft=fish\"
    else
        vim $f
    end

    commandline -r (cat $f)
    commandline -C $p
    command rm $f
end
