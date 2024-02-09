git-unset-proxy() {
  git config --global --unset http.proxy
  git config --global --unset https.proxy

  echo "Git proxy unset"
}


git-set-proxy() {
  local proxy_address="127.0.0.1:7890"

  git config --global http.proxy "http://$proxy_address"
  git config --global https.proxy "http://$proxy_address"

  echo "Git proxy set to $proxy_address"
}
alias idea="/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea"
