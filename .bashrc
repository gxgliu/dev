stty erase 

shopt -s expand_aliases

alias v=/usr/local/bin/vim

alias drun='docker start centos8 ; docker exec -it centos8 /bin/bash'
alias dstop='docker stop centos8'

export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin:/sbin

ENV=~/.env
CMD_ENV=$ENV/cmd.env
GOOGLE_ENV=$ENV/google.env
GNU_ENV=$ENV/gnu.env

OSTYPE=`uname -s`
# macOS
if [ `echo $OSTYPE | egrep -i Darwin` ]; then

	# https://qiita.com/crankcube@github/items/15f06b32ec56736fc43a
	#export PYENV_ROOT=/usr/local/Cellar/pyenv/1.2.15
	#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
	# set 3.7.5 to default version
	#pyenv global 3.8.5

	# to use gls etc.
	if [ -e $GNU_ENV ]; then
		source $GNU_ENV
	fi

	export HOST="Pro"
# Linux
elif [ `echo $OSTYPE | egrep -i Linux` ]; then
	alias ls='/bin/ls --color'
	alias ll='/bin/ls -ltr --color'

	alias u2dt='/bin/date -d "@\!*"'
else
	echo "do nothing"
fi

if [ -e $CMD_ENV ]; then
	source $CMD_ENV
	2utf8
fi

export LESSCHARSET=utf-8

svr_color='\[\e[35m\e[40m\]'
usr_color='\[\e[36m\e[40m\]'
PS1="\![${usr_color}\u\[\e[0m\]@${svr_color}${HOST}\[\e[0m\]:\w]\n\$ "

# setting command-line editing-mode to vi
set -o vi

HISTSIZE=5000
HISTFILESIZE=5000

# for openmpi
export MANPATH=/usr/local/share/man:$MANPATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# for nodebrew
#PATH=$HOME/.nodebrew/current/bin:$PATH

# for maven
#export M3_HOME=/usr/local/share/apache-maven-3.6.3
#M3=$M3_HOME/bin
#export PATH=$PATH:$M3

# for python3
PATH="/usr/local/opt/python@3.9/bin:$PATH"
# for openjdk
PATH="/usr/local/opt/openjdk/bin:$PATH"

umask 022
cd
