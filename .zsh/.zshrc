################################################
## zsh config
## Kouhei Rikiishi
## 21 06, 2019
################################################

#プロンプト表示設定
setopt prompt_subst

#色をつける
autoload colors
colors

# 右側にホスト名を表示
#RPROMPT="%B%(?.%{$fg_bold[blue]%}.%{$fg_bold[white]$bg[red]%})[${HOST}]%{$reset_color%}"

# もしかして？
setopt correct

# Zshをかわいくする
SPROMPT="%{$fg[magenta]%}Command not found. Perhaps, %B%{${fg[cyan]}%}%r%b%{$fg[magenta]%} ? [Yes(y),No(n),a,e]:%{${reset_color}"

# 左側にカレントディレクトリを表示する
#PROMPT="
#%{$fg_bold[cyan]%}%d$reset_color%}
#%(?.%{$fg_bold[green]%}.%{${fg_bold[red]}%})%n > "

PROMPT="                                                                          
%{$fg_bold[cyan]%}%d$reset_color%}
> "

#PROMPT2='[%n]> '

# 自動補完を有効に
autoload -U compinit; compinit

# lsに色を付ける
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -GF"
        ;;
    linux*)
        alias ls="ls -F --color"
        ;;
esac

##-- alias conf

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias mailer='alpine'
alias gs='git status'
alias sl='sl; tw --yes "slコマンドが実行されました"'

# g++ のエイリアス
alias g++='g++ -stdc++1y'

# シェルの再起動(relogin)
alias relogin='exec $SHELL -l'

# python楽にするマン
alias py='python'

# emacs 短縮
alias e='emacs -nw'

# google で検索できる
function google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            str="$str+$i"
        done
        str=`echo $str | sed 's/^\+//'`
        opt='search?num=50&hl=ja&lr=lang_ja'
        opt="${opt}&q=${str}"
    fi
    w3m http://www.google.co.jp/$opt
    
}

# 補完候補をハイライト
zstyle ':completion:*:default' menu select=0
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'

# 候補に色を付ける
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# pyenvにパスを通す
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# jupyter notebookのエイリアス
alias jn='jupyter notebook'

# nodebrewにパスを通す
export PATH=$HOME/.nodebrew/current/bin:$PATH

# rbenvにパスを通す
export PATH="$HOME/.rbenv/shims:$PATH"
