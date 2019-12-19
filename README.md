# dev-config
```
cd
rm -rf ~/dev-config
git clone https://github.com/szfck/dev-config.git

# zsh
rm -rf .oh-my-zsh
git config --global http.proxy fwdproxy:8080
git config --global https.proxy fwdproxy:8080
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -x fwdproxy:8080
# now inspect the output
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -x fwdproxy:8080)"

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp ~/dev-conf/.zshrc ~/
source ~/.zshrc

# tmux
rm -rf ~/.tmux*
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
cat ~/dev-config/append_to_tmux_conf_local.txt >> ~/.tmux.conf.local

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ~/dev-config/.vimrc ~/
vim -c 'PluginInstall' -c 'qa!'

```

# iterm2 and color

```
# iterm2
brew install iterm2
iterm2 import colors: Solarized Dark - Patched.itermcolors
iTerm2 (iTerm → Preferences → Profiles → Text → Change Font) [SourceCodePro+Powerline+Awesome+Regular.ttf]

# theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
Then edit your ~/.zshrc
ZSH_THEME="powerlevel9k/powerlevel9k"

```
