#!/bin/bash
set -eu

DIR_DOTFILES_REPOS="${HOME}"/repos/dotfiles
DIR_DOT_SSH="${HOME}"/.ssh

# configディレクトリの作成
if [ ! -d "${HOME}"/.config ]; then
	echo "Creating config directory..."
	mkdir "${HOME}"/.config
fi

# Homebrewのインストール
if ! command -v brew &> /dev/null; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Homebrew already installed."
fi

# dotfilesのclone
if [ ! -d "${DIR_DOTFILES_REPOS}" ]; then
	if [ ! -f "${DIR_DOT_SSH}/id_rsa_github" ]; then
		ssh-keygen -t rsa -b 4096 -f "${DIR_DOT_SSH}/id_rsa_github" -N ""
	fi
	pbcopy < "${DIR_DOT_SSH}"/id_rsa_github.pub
	echo "Have you registered your public key with GitHub?"
	select answer in "Yes"; do
		case $answer in
			Yes ) break;;
		esac
	done

	echo "Cloning dotfiles..."
	git clone git@github.com:rk0uhey/dotfiles.git "${DIR_DOTFILES_REPOS}"
else
	echo "dotfiles already cloned."
fi

# MacOSの設定を変更
echo 'Changing MacOS settings'
/bin/bash "${DIR_DOTFILES_REPOS}"/dotfiles/macos/defaults.sh

# Brewfileに記載のソフトをインストール
echo "Installing Brewfile..."
brew bundle -v --file="${DIR_DOTFILES_REPOS}"/Brewfile

# dotfilesのシンボリックリンクをはる
echo "Symlinking dotfiles..."
stow -v -d "${DIR_DOTFILES_REPOS}"/dotfiles -t "${HOME}" zsh vscode git

# VSCodeの拡張をインストール
cat "${DIR_DOTFILES_REPOS}"/vscode/extensions | xargs -n 1 code --install-extension

# zsh を再起動して反映
echo "Reloading zsh..."
exec zsh
