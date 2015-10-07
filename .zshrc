#gopath
export GOPATH=$HOME/go
export PATH="/Users/kinoshita/go/bin:$PATH"

#rbenv
if which rbenv >& /dev/null; then
	eval "$(rbenv init - )";
fi

export PATH="/usr/local/bin:$PATH"



#plenv
eval "$(plenv init -)"

#pyenv
if which pyenv >& /dev/null; then
	eval "$(pyenv init -)";
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# prompt
PROMPT="[%n@%m] "               # left prompt
RPROMPT="[%~]%1(v|%1v|)"     # right prompt
#git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

setopt transient_rprompt     # if typed chars conflict right prompt, hide right prompt


#alias
alias shoes="/Applications/Shoes.app/Contents/MacOS/shoes"

#commands history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

#シェルの再起動
alias restart='exec zsh -l'


#gnuplot
export GNUTERM=latex

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export TERM=xterm-256color
