# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 5000
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
    source ("/run/current-system/sw/bin/starship" init fish --print-full-init | psub)
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

if status --is-interactive # && type -q tinyfetch
    # pywal colors
    cat ~/.cache/wal/sequences
    # tinyfetch
    greeter
end

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

zoxide init fish | source
. /home/thatmagicalcat/export-esp.sh

set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -gx PNPM_HOME "/home/thatmagicalcat/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

source $HOME/.config/fish/alias.fish
source $HOME/.config/fish/env.fish
source $HOME/.config/fish/completions/*.fish
