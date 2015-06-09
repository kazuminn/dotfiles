#rbenv 
if which rbenv >& /dev/null; then 
	eval "$(rbenv init - )"; 
fi 

export PATH="/usr/local/bin:$PATH"



#plenv
if which pyenv >& /dev/null; then
	eval "$(pyenv init -)";
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# prompt 
PROMPT="[%n@%m] "               # left prompt
RPROMPT="[%~]%1(v|%1v|)"     # right prompt
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

#AA
cat AAA.vim 
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

