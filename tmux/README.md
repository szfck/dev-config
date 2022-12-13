```
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
```
