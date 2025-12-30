alias ls='eza -al --color=always --group-directories-first --icons'
alias la='eza -a --color=always --group-directories-first --icons'
alias ll='eza -l --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.="eza -a | egrep '^\.'"
alias cat='bat --style header --style snip --style changes --style header'
alias ip="ip -color"
alias so="source ~/.config/fish/config.fish"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias fish_config="nvim ~/.config/fish/config.fish"
alias g="git"
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"
alias ff="fastfetch"
alias c="cargo"
alias rh="runhaskell"
alias download_song="yt-dlp -x --audio-format mp3 --embed-thumbnail"
alias ssh_phone="ssh -p 8022 u0_a272@192.168.0.101"
alias cleanup_rust_projects="/usr/bin/ls | xargs --replace={} rm -rf ./{}/target"
alias py="python3"
alias btctl="bluetoothctl"
alias bigpkgs="for pkg in (xbps-query -l | awk '{print $2}'); echo (xbps-query -p installed_size $pkg 2>/dev/null) $pkg; end | sort -h"
alias gcc="/usr/bin/gcc -Wall -Wextra"
alias g++="/usr/bin/g++ -Wall -Wextra"
alias tb="nc termbin.com 9999"
alias nrw="sudo nixos-rebuild switch --flake $HOME/nix --cores 4"
alias nv="neovide &"
alias delete_nix_generations="sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +10" # keep last 10
alias zell="zellij"
alias v="nvim"

# NixOS btw
# alias xi="sudo xbps-install"
# alias xr="sudo xbps-remove"
# alias xq="xbps-query"
# alias xivp="sudo xbps-install --repository $HOME/void-packages/hostdir/binpkgs "
