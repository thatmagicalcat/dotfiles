export DOTLINK_ROOT="/home/thatmagicalcat/dotfiles"
export BROWSER="zen"
export XBPS_DISTDIR="~/void-packages"
export STARSHIP_CONFIG="/home/thatmagicalcat/.config/starship.toml"
export QT_QPA_PLATFORM="wayland"

source $HOME/.config/fish/completions/*.fish

export RUSTC_WRAPPER=sccache
export FLYCTL_INSTALL="/home/thatmagicalcat/.fly"

export PATH="$PATH":"$HOME/.local/share/gem/ruby/3.4.0/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/.emacs.d/bin"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

export RUSTFLAGS="-C linker=clang -C link-arg=-fuse-ld=lld"

set -p PATH ~/.cargo/bin
set -p PATH /home/thatmagicalcat/.platformio/penv/bin

# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

if status --is-interactive
    source ("/usr/bin/starship" init fish --print-full-init | psub)
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function short_pwd
    pwd | sed -e "s|$HOME|~|"
end

function fish_right_prompt
    echo -n "[ $(short_pwd) ] $(date "+%H:%M:%S") "
    # echo -n (date "+%H:%M:%S")
end

function silent
    eval "$argv > /dev/null 2> /dev/null"
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## run a fetch program if session is interactive
if status --is-interactive && type -q tinyfetch
    # pywal colors
    cat ~/.cache/wal/sequences &
    echo
    tinyfetch
    greeter
end


# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons' # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'" # show only dotfiles


# replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes --style header'

# Common use
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
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='grep -E --color=auto'
alias fish_config="nvim ~/.config/fish/config.fish"
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

alias g="git"
alias gs="git status"
alias gc="git commit -m"
alias gp="git push"

alias docker="sudo docker"

alias c="cargo"
alias rh="runhaskell"
alias download_song="yt-dlp -x --audio-format mp3 --embed-thumbnail"
alias ssh_phone="ssh -p 8022 u0_a272@192.168.0.101"
alias cleanup_rust_projects="/usr/bin/ls | xargs --replace={} rm -rf ./{}/target"
alias py="python3"
alias btctl="bluetoothctl"

# empty rust project for random stuff
alias t="z /tmp && rm -rf t && cargo new t && z t"

alias gcc="/usr/bin/gcc -Wall -Wextra"
alias g++="/usr/bin/g++ -Wall -Wextra"

alias xi="sudo xbps-install"
alias xr="sudo xbps-remove"
alias xq="xbps-query"
alias xivp="sudo xbps-install --repository $HOME/void-packages/hostdir/binpkgs "

function yplay
    set -l query (read -P "Search YouTube: ")
    if test -z "$query"
        echo "No search query given."
        return
    end

    set -l url (yt-dlp "ytsearch10:$query" --flat-playlist --print "%(title)s | https://youtu.be/%(id)s" | fzf | cut -d'|' -f2 | string trim)

    if test -z "$url"
        echo "No selection made."
        return
    end

    mpv --no-video (yt-dlp -f bestaudio -g $url)
end

function ydownload
    set -l query (read -P "Search YouTube: ")
    if test -z "$query"
        echo "No search query given."
        return
    end

    set -l url (yt-dlp "ytsearch10:$query" --flat-playlist --print "%(title)s | https://youtu.be/%(id)s" | fzf | cut -d'|' -f2 | string trim)

    if test -z "$url"
        echo "No selection made."
        return
    end

    echo "Downloading audio from: $url"

    yt-dlp \
        -f bestaudio \
        --extract-audio \
        --audio-format mp3 \
        --audio-quality 0 \
        --embed-thumbnail \
        --add-metadata \
        --output "$HOME/Music/%(title)s.%(ext)s" \
        $url
end

set -x MANPAGER bat

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin $PATH /home/thatmagicalcat/.ghcup/bin # ghcup-env

alias nv="neovide &"

zoxide init fish | source
