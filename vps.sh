wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
rpm -ivh epel-release*


cmd="apt-get"
if [[ $(command -v yum) ]]; then

	cmd="yum"

fi

$cmd update
$cmd install -y git zip unzip curl wget vim zsh tmux mosh

# # firewalld放行端口（适用于CentOS7/8）
firewall-cmd --permanent --add-port=60001/udp # mosh port
firewall-cmd --reload