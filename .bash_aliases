[ `uname` = "Linux" ] && alias open='xdg-open 2>/dev/null'

alias nr="nim c --run"
alias ssh_start="systemctl start sshd"
alias python="python3"
alias pbcopy='xsel --clipboard --input'
alias g++11='g++-6 -std=c++11 -O2 -Wall'
alias g++14='g++-6 -std=c++14 -O2 -Wall'
alias la="ls -a"
alias ll="ls -l"
alias vim="nvim"
alias py-reqirements='pip freeze > requirements.txt'

export switch_tori="ajima"

ggl() {
    open "https://www.google.co.jp/search?q=${*// /%20}"
}

urxvt_reload() {
  xrdb -remove
  xrdb -merge ~/.Xresources
  }

# function {{{
set_proxy() {
  export http_proxy="http://cproxy.okinawa-ct.ac.jp:8080"
  export https_prxoy=$http_proxy
  export ftp_proxy=$http_proxy
  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export FTP_PROXY=$http_proxy

#  apm config set https-proxy $http_proxy
#  apm config set https-proxy $http_proxy
  git config --global http.proxy $http_proxy
  npm config set proxy $http_proxy
  npm config set https-proxy $http_proxy
  alias sudo="sudo -E"
  if [ -f ~/.curlrc.conf ]; then 
    mv ~/.curlrc.conf ~/.curlrc
  fi
  if [ -f ~/.wgetrc.conf ]; then 
    mv ~/.wgetrc.conf ~/.wgetrc
  fi
  echo "Proxy environment variable set."
}

unset_proxy() {
  unset http_proxy
  unset https_prxoy
  unset HTTP_PROXY
  unset HTTPS_PROXY

  git config --global --unset http.proxy
  npm config delete proxy
  npm config delete https-proxy
#  apm config delete http-proxy
#  apm config delete https-proxy
  if [ -f ~/.curlrc ]; then 
    mv ~/.curlrc ~/.curlrc.conf
  fi
  if [ -f ~/.wgetrc ]; then 
    mv ~/.wgetrc ~/.wgetrc.conf
  fi
  echo -e "Proxy environment variable removed."
}
# }}}


function get_ssid() {
    echo `nmcli dev status | grep '接続済み' | awk '{print $4}'`
}

echo `get_ssid`

if [ "`get_ssid`" = "$switch_tori" ]; then
    echo -e "\e[31mSwitch to proxy for school network\e[m"
    set_proxy
else
    echo -e "\e[36mUnset proxy settings\e[m"
    unset_proxy
fi
