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

# Auto suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
plugins=(zsh-autosuggestions)

# Syntax highlighting
brew install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# theme
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
Then edit your ~/.zshrc
ZSH_THEME="powerlevel10k/powerlevel10k".
POWERLEVEL9K_MODE="awesome-patched"

DEFAULT_USER=`whoami`
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
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
