stty erase 

shopt -s expand_aliases

alias vim=/usr/local/bin/vim
alias v=vim
export EDITOR=vim
alias python=/usr/local/opt/python@3.10/bin/python3

export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/bin:/sbin
export HOST=`/bin/hostname | sed -e 's/.yahoo.co.jp//'`

ENV=~/.env
CMD_ENV=$ENV/cmd.env
YJ_ENV=$ENV/YJ.env
SERVER_ENV=$ENV/server.env
GOOGLE_ENV=$ENV/google.env
GNU_ENV=$ENV/gnu.env

OSTYPE=`uname -s`
# macOS
if [ `echo $OSTYPE | egrep -i Darwin` ]; then
	export "OS=macOS"
	alias yssh='/usr/bin/ssh -i /Users/ganxiang/.ssh/id_rsa'
	alias yscp='/usr/bin/scp -p -i /Users/ganxiang/.ssh/id_rsa'

	# # https://qiita.com/crankcube@github/items/15f06b32ec56736fc43a
	# export PYENV_ROOT=/usr/local/Cellar/pyenv/1.2.15
	# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
	# # set 3.7.5 to default version
	# pyenv global 3.8.5

	# to use gls etc.
	if [ -e $GNU_ENV ]; then
		source $GNU_ENV
	fi

	export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home

	export HOST="YJ Pro"
# Linux
elif [ `echo $OSTYPE | egrep -i Linux` -a `/bin/hostname | egrep yahoo.co.jp` ]; then
	export "OS=Linux"
	alias ls='/bin/ls --color'
	alias ll='/bin/ls -lTtr --color'
else
	echo "do nothing"
fi

if [ -e $CMD_ENV ]; then
	source $CMD_ENV
	2utf8
fi

export LESSCHARSET=utf-8

if [[ "$HOST" = *.ynwm* ]]; then
	svr_color='\[\e[33m\e[40m\]'
else
	svr_color='\[\e[35m\e[40m\]'
fi
usr_color='\[\e[36m\e[40m\]'
# if [ `echo $OSTYPE | egrep -i Darwin` ]; then
	# PS1="\! ${svr_color}${HOST}\[\e[0m\]:\w]\\$ "
# else
	# PS1="\! \[${usr_color}\u\[\e[0m\]@${svr_color}${HOST}\[\e[0m\]:\w]\\$ "
# fi
PS1="\![${usr_color}\u\[\e[0m\]@${svr_color}${HOST}\[\e[0m\]:\w]\n\$ "

# setting command-line editing-mode to vi
set -o vi

HISTSIZE=5000
HISTFILESIZE=5000

# for some shopping servers
#if [ -e $SERVER_ENV ]; then
#	source $SERVER_ENV
#fi

# for searching keyword at command line via google search api
if [ -f $GOOGLE_ENV ]; then
	source $GOOGLE_ENV
fi

# for openmpi
export MANPATH=/usr/local/share/man:$MANPATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

# for nodebrew
PATH=$HOME/.nodebrew/current/bin:$PATH

# for maven
export M3_HOME=/usr/local/Cellar/maven/3.8.4/libexec
M3=$M3_HOME/bin
export PATH=$M3:$PATH

# for apache installed via Homebrew
export PATH=/usr/local/Cellar/httpd/2.4.54_1/bin:${PATH}

# for ynwm
DEV=ganxiang.dev.ssk.ynwm.yahoo.co.jp
alias dev='ssh -i /Users/ganxiang/.ssh/id_rsa ganxiang.dev.ssk.ynwm.yahoo.co.jp'

# https://qiita.com/satoruk/items/de24deaa10e9c8241e48
#ssh-add -K ~/.ssh/id_rsa

# for php
export PATH="/usr/local/opt/php@8.0/bin:$PATH"
export PATH="/usr/local/opt/php@8.0/sbin:$PATH"

# for python
export PATH="/usr/local/opt/python@3.10/bin:$PATH"

# for w3m
alias w3m='/usr/local/bin/w3m -I utf-8 -O utf-8 -m -num -s'

# for Box
alias box='gt /Users/ganxiang/Library/CloudStorage/Box-Box'
alias sec='gt /Users/ganxiang/Library/CloudStorage/Box-Box/CORP-financial_dev/セキュリティ推進/'
alias mtg='gt /Users/ganxiang/Library/CloudStorage/Box-Box/HOME-ganxiang/mtg_memo'

# for openssl
export PATH="/usr/local/opt/openssl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# for Snyk REST APIs
export SNYK_TOKEN=`cat ~/.ssh/api-key_snyk.txt`

# for ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

umask 022
cd
