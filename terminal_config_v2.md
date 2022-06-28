```
# ubuntu docker
apt update
apt install -y vim curl git tmux zsh software-properties-common


# tmux
cd ~
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

# append to .tmux.conf.local
cat > /tmp/append.txt <<- EOM
set-option -g repeat-time 1
set-option -g default-shell /usr/bin/zsh
tmux_conf_theme_status_left='  #S | '                                                                                                             
tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized}, %R , %d %b |' 
tmux_conf_theme_status_left_bg='#00afff,#00afff,#00afff' 
set-option -g status-position bottom  
set-option -g repeat-time 1  
set-window-option -g mode-keys vi
EOM

cat /tmp/append.txt >> .tmux.conf.local

# on-my-zsh
sh -c "$(curl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# plugin
cd ~
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# ~/.zshrc
cat > /tmp/append.txt <<- EOM
plugins=(
zsh-syntax-highlighting
zsh-autosuggestions
)
EOM
cat /tmp/append.txt >> ~/.zshrc
source ~/.zshrc

# neovim
cd ~
git clone https://github.com/neovim/neovim
apt install -y pkg-config make cmake g++ unzip libtool-bin gettext

cd neovim 
make CMAKE_BUILD_TYPE=RelWithDebInfo
make install

mkdir -p ~/.config/nvim/lua
curl https://raw.githubusercontent.com/szfck/dev-config/master/neovim/init.lua > ~/.config/nvim/init.lua
curl https://raw.githubusercontent.com/szfck/dev-config/master/neovim/lua/mappings.lua > ~/.config/nvim/lua/mappings.lua
curl https://raw.githubusercontent.com/szfck/dev-config/master/neovim/lua/options.lua > ~/.config/nvim/lua/options.lua
curl https://raw.githubusercontent.com/szfck/dev-config/master/neovim/lua/plugins.lua > ~/.config/nvim/lua/plugins.lua

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'TSUpdate' -c 'qall'

# entr
cd ~
git clone https://github.com/eradman/entr
cd entr
./configure
make test
make install


# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "PATH=\$PATH:$HOME/.cargo/bin" >> ~/.zshrc

# leetup
cd ~
git clone https://github.com/dragfire/leetup
cd leetup
cargo build 
```

