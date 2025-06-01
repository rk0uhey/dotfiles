#!/bin/bash
set -eu

APP_LIST=(
	"Dock"
	"Finder"
)

# Dock
## Dock の位置（左）
defaults write com.apple.dock orientation -string "left"
## Dock のサイズ
defaults write com.apple.dock tilesize -int 60
## 拡大機能を無効化
defaults write com.apple.dock magnification -bool false
## 起動中のアプリにインジケータを表示
defaults write com.apple.dock show-process-indicators -bool true
## 最近使ったアプリを非表示
defaults write com.apple.dock show-recents -bool false
## Dock の自動非表示を無効化
defaults write com.apple.dock autohide -bool false
## アプリ最小化をアプリに格納しない
defaults write com.apple.dock minimize-to-application -bool false

# Finder
## 隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles -bool true

# 再起動
for app in "${APP_LIST[@]}"; do
	killall "${app}" &> /dev/null
done
