# zsh設定ファイル
## 反映方法
ホームディレクトリに`.zshenv`を配置し、その中でパスを指定
```
> cd
> touch .zshenv
> echo export ZDOTDIR=$HOME/dotfiles/.zsh > .zshenv
> echo source $ZDOTDIR/.zshenv
```
この後、シェルを再起動する