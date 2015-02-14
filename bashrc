# only run if we have an interactive shell
if [ $(expr index "$-" i) -eq 0 ]; then
    return
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#alias to get the dbus session
shopt -s expand_aliases
alias getdbus="export DBUS_SESSION_BUS_ADDRESS=`cat /proc/$(pidof kded4)/environ | tr '\0' '\n' | grep DBUS | cut -d '=' -f2-`"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

#Keep a large shell history
export HISTFILESIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# colours: piatek   green   32;1
#          cajun    cyan    36;1
#          *.doc    yellow  33;1
#          kalimdor magenta 35;1
#          root@*   red     31;1
#PS1="[\[\033[1;35m\u@\h\]\[\033[1;34m \w\[\[\033[0m ]%\] "

case "$TERM" in
xterm|xterm-color)
    #Don't think ive ever used the debian chroot stuff... 
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    #TODO: detect root?
    # Magic bit here gives rc of last cmd, red if non 0. Also have user@host:path for scp help :)
    PS1="\[\033[0;31m\]\${?##0}\[\033[0m\]\u@\[\033[1;31m\]\h\[\033[0m\]:\w\$ "

    # alternative - smiley face for rc 0, else :(
    # PS1=':$( [ $? == 0 ] && echo ") " || echo "( " )'
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    #eval "`dircolors -b`"
    eval $(dircolors ~/code/solarized-files/ls-colors-solarized)
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'

fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#make grep color
alias grep="grep --color=auto"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export PATH=~/bin/:/Development/ode/5.0:/usr/local/bin:$PATH


# Debian packaging options
export DEBEMAIL=anton.piatek@uk.ibm.com
export QUILT_PATCHES=debian/patches
export QUILT_REFRESH_ARGS="-p ab --no-timestamps --no-index"

#fixes for synergy keycodes
echo "keycode 52 = z Z less less less less" | xmodmap -
echo "keycode 53 = x X greater greater greater greater" | xmodmap -

alias x11vnc="x11vnc -usepw"


#Load MQ env
#. /opt/mqm/bin/setmqenv -p /opt/mqm
# NOOOOOO - might be what is causing a broken $PATH and causing random things to exit the shell

function devtest
{
  if [[ -e /devtest/broker_bash_profile ]];
  then
    echo Loading bash profile from devtest
    . /devtest/broker_bash_profile
  fi
}

function sbb
{
        setBrokerBuild $*
        export PERL5LIB=~/workspaces/jazz/com.ibm.broker.test:~/workspaces/jazz/com.ibm.broker.test.cs:$PERL5LIB
        echo PERL5LIB=$PERL5LIB
        export MQTROOTPATH=~/workspaces/jazz/com.ibm.broker.test
        echo MQTROOTPATH=$MQTROOTPATH
        gsa_logger apiatek ~/.gsa tail -f /dev/null&
        cd ~/bath/

}
function mantest
{
        #Manufacturing 
        MAN=~/workspaces/industry/Manufacturing/workspace
        export PERL5LIB=$MAN/AutomationTestMaterial/:$PERL5LIB
        echo PERL5LIB=$PERL5LIB
        export MQTROOTPATH=$MAN/AutomationTestMaterial:$MQTROOTPATH
        echo MQTROOTPATH=$MQTROOTPATH
}


export JAVA_HOME=/usr/lib/j2sdk1.7-ibm/

#ODE classpath options - only if we appear to be in an ODE session
if [[ -n $SANDBOXDIR ]]; then
  source /Development/devprofile
  echo "ODE Sandbox detected - Setting ODE build variables"
  export CLASSPATH=$SANDBOXDIR/export/classes/:$CLASSPATH
  export BTYPE=D
  alias mk="mk -j3"
  echo "Commands you may want:"
  echo ". /Development/current_back/src/setreloc.sh /broker_registries/anton /Development/rrr/ /Development/current_back"
  echo "mk -j10 OPT_LEVEL="-g -O0" BTYPE=D && mk install_all"
fi;

# general ODE specific settings
alias workon="workon -m amd64_linux_2"

# JDBC settings for broker JDBC scripts
#MQTEST_JDBC_JAR_DIR=/home/anton/JDBCRepository
#MQTEST_JDBCINI=/home/anton/JDBCRepository/JDBCConfig.xml
export MQTEST_JDBC_JAR_DIR=/broker/nonship/jdbc/
export MQTEST_JDBCINI=/auto/jdbc.broker.ini

#plugins for clipboard and remote sound
alias rd='/usr/bin/xfreerdp --plugin cliprdr --plugin rdpsnd -g 1280x800 -u argotst'

alias sl="sl -e"
alias o="xdg-open"



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#export gradle path
#TODO move to work-specific bashrc file
export PATH=~/gradle-1.12/bin:$PATH
