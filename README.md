# dev-config

```
# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
copy .vimrc

# iterm2
brew install iterm2
iterm2 import colors: Solarized Dark - Patched.itermcolors
iTerm2 (iTerm → Preferences → Profiles → Text → Change Font) [SourceCodePro+Powerline+Awesome+Regular.ttf]

# oh-my-zsh
install zsh
install oh-my-zsh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

Then edit your ~/.zshrc
ZSH_THEME="powerlevel10k/powerlevel10k".
POWERLEVEL9K_MODE="awesome-patched"
DEFAULT_USER=`whoami`


# tmux
cp .tmux.conf
cp .tmux.conf.local

```
