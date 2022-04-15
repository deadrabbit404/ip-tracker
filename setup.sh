#!/bin/bash
# setup and install iptracker to your system
# By: DeadRabbit
# Telegram: t.me/deadrabbit404
# Github: github.com/deadrabbit404

termuxbin="/data/data/com.termux/files/usr/bin"
homebin="$HOME/bin"
localbin="/usr/local/bin"
usrbin="/usr/bin"
progname="iptracker"

printf ":: Installing iptracker...\n"
sleep 1
chmod 755 $progname

# Install to termux
if [ -d "$termuxbin" ]; then
    cp -rv $progname $termuxbin && printf ":: Installation successfull\n"
    sleep 1

    # Integrate iptracker with t-ui launcher
    tui="/storage/emulated/0/t-ui"
    if [ -d "$tui" ]; then
        behaviorxml="$tui/behavior.xml"
        aliastxt="$tui/alias.txt"
        scriptdir=$tui/script

        printf ":: t-ui folder detected\n"
        sleep 1
        printf ":: Integrating $progname with t-ui launcher...\n"
        sleep 2
        mkdir -p $scriptdir && cp -rv $progname $scriptdir

        # Get the alias_param_marker
        alias_param_marker=$(grep alias_param_marker $behaviorxml \
            | grep -o 'value=".*"' | cut -f 2 -d= | tr -d '"')

        # Create `myip` alias
        grep '^myip=' $aliastxt >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            sed -i "s#\(^myip=\).*\$#\1sh $scriptdir/$progname#" $aliastxt \
                && printf ":: Alias updated:\n   myip=sh $scriptdir/$progname\n"
        else
            [ -n "`tail -c 1 $aliastxt`" ] && echo >> $aliastxt
            echo "myip=sh $scriptdir/$progname" >> $aliastxt \
                && printf ":: Alias created:\n   myip=sh $scriptdir/$progname\n"
        fi

        # Create `iptrack` alias
        grep '^iptrack=' $aliastxt >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            sed -i "s#\(^iptrack=\).*\$#\1sh $scriptdir/$progname $alias_param_marker#" $aliastxt \
                && printf ":: %s:\n    %s\n" "Alias updated" "iptrack=sh $scriptdir/$progname $alias_param_marker"
        else
            [ -n "`tail -c 1 $aliastxt`" ] && echo >> $aliastxt
            echo "iptrack=sh $scriptdir/$progname $alias_param_marker" >> $aliastxt \
                && printf ":: %s:\n    %s\n" "Alias created" "iptrack=sh $scriptdir/$progname $alias_param_marker"
        fi

        # Test if all goes well
        [ $? -eq 0 ] && printf ":: T-UI integration successful, please refresh or restart t-ui launcher\n" \
                     || printf ":: Integration failed: Please create the aliases manually"

    fi

# Install to linux system    
else
    # Try to install to $HOME/bin
    if [ -d "$homebin" ]; then
        grep "$homebin" <<< $PATH >/dev/null 2>&1 && cp -rv $progname $homebin

    # Try to install to /usr/local/bin
    elif [ -d "$localbin" ]; then
        if [ -f "`which sudo`" ]; then
            sudo cp -rv $progname $localbin 
        else
            su -c "cp -rv $progname $localbin"
        fi

    # Install to /usr/bin
    else
        if [ -f "`which sudo`" ]; then
            sudo cp -rv $progname $usrbin 
        else
            su -c "cp -rv $progname $usrbin"
        fi

    fi

    # Print a message if install is success or failed
    [ $? -eq 0 ] && printf ":: Installation successfull\n" \
                 || printf ":: Installation failed\n"
fi
