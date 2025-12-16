# SECRETS SHOULD LIVE IN .env FILES. 
# for file in $HOME/*.env; do source "$file"; done
source "$HOME/.cargo/env"

alias vpnstate="/opt/cisco/anyconnect/bin/vpn state"
alias vpndisconnect="/opt/cisco/anyconnect/bin/vpn disconnect"
alias vpnmbiz="printf '\n$VPNMBIZ\n' | /opt/cisco/anyconnect/bin/vpn -s connect $VPNMBIZHOST"

alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias chrome-canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"
alias chromium="/Applications/Chromium.app/Contents/MacOS/Chromium"

alias gitstatus="git status"
alias gitpull="git pull"
alias gitlog="git log"
alias gitcommitm="git commit -m"
alias npmrun="npm run"
alias tmls="tmux ls"
alias tmnew="tmuxnew"

alias le="exa -a"
alias md="mkdir -p"

export EDITOR="nv"

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64  # presumably consistent with `update-alternatives --config java`

# WSL
export ANDROID_HOME=/mnt/c/Users/rezah/AppData/Local/Android/Sdk
alias adb=/mnt/c/Users/rezah/AppData/Local/Android/Sdk/platform-tools/adb.exe

# also present in .zshrc, test removing:
# bindkey "^P" up-line-or-search
# bindkey "^N" down-line-or-search
