# zsh設定ファイル
## 反映方法
### その1
sourceを指定
```
> source /zsh_configuration/.zshrc
```

### その2
ホームディレクトリにzshenvを配置し、その中でパスを指定
```
> touch .zshenv
> echo export ZDOTDIR=dotfiles/.zsh.d > .zshenv
```