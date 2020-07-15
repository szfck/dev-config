wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
rpm -ivh epel-release*


cmd="apt-get"
if [[ $(command -v yum) ]]; then

	cmd="yum"

fi

install() {
	$cmd update
	$cmd install -y git zip unzip curl wget vim zsh tmux mosh
	# rm -rf ~/dev-config
	# git clone https://github.com/szfck/dev-config.git
	install_zsh
	install_tmux
}


install_zsh() {
	# zsh
	chsh -s /bin/zsh root
	echo $SHELL
	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	sed -i -e 's/(git)/(git z zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
	source ~/.zshrc
	# plugin
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}


install_tmux() {
	# tmux
	cd
	git clone https://github.com/gpakosz/.tmux.git
	ln -s -f .tmux/.tmux.conf
	cp .tmux/.tmux.conf.local .
	# append new setting
	cat >> ~/.tmux.conf.local <<EOL
tmux_conf_theme_status_left='  #S | '
tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized}, %R , %d %b |'
tmux_conf_theme_status_left_bg='#00afff,#00afff,#00afff'
set-option -g repeat-time 1
set-option -g status-position top
set-window-option -g mode-keys vi
EOL

}

install

# # firewalld放行端口（适用于CentOS7/8）
firewall-cmd --permanent --add-port=60001/udp # mosh port
firewall-cmd --reload