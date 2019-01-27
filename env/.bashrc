# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi



# User specific environment

# Sets bundle path to PATH to get bin files
export PATH="$PATH:$BUNDLE_PATH"
export USER=`whoami`

# Color wrappers
# @see https://misc.flogisoft.com/bash/tip_colors_and_formatting
echo_green () {
  ARGS=$@
  GREEN_WRAPPER_BEGIN='\e[01;32m'
  GREEN_WRAPPER_END='\e[00m'
  echo -e $GREEN_WRAPPER_BEGIN$ARGS$GREEN_WRAPPER_END
}



# Custom PS1 prompt
#
# @see "Easy Bash PS1 Generator" - http://ezprompt.net/
# @see https://bash.cyberciti.biz/guide/Changing_bash_prompt
# @see https://www.linuxnix.com/linuxunix-shell-ps1-prompt-explained-in-detail/
# @see https://misc.flogisoft.com/bash/tip_colors_and_formatting
# @see https://www.digitalocean.com/community/tutorials/how-to-customize-your-bash-prompt-on-a-linux-vps
#
# @see Prompt examples and ideas:
# https://misc.flogisoft.com/bash/tip_customize_the_shell_prompt
# https://www.thegeekstuff.com/2008/09/bash-shell-ps1-10-examples-to-make-your-linux-prompt-like-angelina-jolie#comments
#
#
export PS1_BACKUP="$PS1"
export PROMPT_COMMAND_BACKUP="$PROMPT_COMMAND"

# @see https://misc.flogisoft.com/bash/tip_colors_and_formatting
PS1_USER_COLOR="\e[01;32m"
if [[ $USER = 'root' ]]; then
  # root user?
  PS1_USER_COLOR="\e[38;5;226m"
fi

#PS1_H=$(hostname | cut -d. -f 2)
PS1_H="docker-alpine"
PS1_USER_AND_HOST='\['$PS1_USER_COLOR'\]\u@'$PS1_H'\[\e[00m\]'
PS1_CURRENT_DIR='\[\e[01;34m\]\w\[\e[00m\]'
PS1_TTYNAME=$(tty | cut -b 6-)
PS1_DATE=$(date +"%Y-%m-%d")' \t'
PS1_PROMPT_SIGN='\n\$ '
PS1_PROMPT_SIGN2='\n♫ ' #§✿♫読本

export PROMPT_COMMAND="echo" # newline after command execution
export PS1="$PS1_USER_AND_HOST:$PS1_CURRENT_DIR$PS1_PROMPT_SIGN2"
#export PS1='\[\e[38;5;226m\]\u@'$H'\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\e[36m\] () \[\e[m\n\$ '

# Adds PS1 for the terminal tab
# PS1_FOR_TERM='\[\e]0;\u@'$PS1_H' ('$PS1_TTYNAME')\]'
PS1_FOR_TERM_TITLEBAR="\[\e]0;\u@\h: \w\a\]"
case "$TERM" in
xterm*|rxvt*)
    PS1="$PS1_FOR_TERM_TITLEBAR$PS1"
    ;;
*)
    ;;
esac


# Konnichiwa
echo_green "Starting shell ^^"
