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

install zsh-autosuggestions
install zsh-syntax-highlighting

# theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
Then edit your ~/.zshrc
ZSH_THEME="powerlevel9k/powerlevel9k"

DEFAULT_USER=`whoami`
alias d="dirs -v | head -10"
1='cd -'
2='cd -2'
3='cd -3'
4='cd -4'
5='cd -5'
6='cd -6'
7='cd -7'
8='cd -8'
9='cd -9'


# tmux
cp .tmux.conf
cp .tmux.conf.local

```
