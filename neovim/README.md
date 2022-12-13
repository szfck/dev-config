```
# Install on Mac
brew install neovim

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'TSUpdate' -c 'qall'

# Config
mkdir -p ~/.config/neovim
touch init.lua
```
