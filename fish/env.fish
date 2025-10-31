# export RUSTFLAGS="-C linker=clang -C link-arg=-fuse-ld=/usr/bin/mold"

export DOTLINK_ROOT="/home/thatmagicalcat/dotfiles"
export BROWSER="zen"
export XBPS_DISTDIR="~/void-packages"
export STARSHIP_CONFIG="/home/thatmagicalcat/.config/starship.toml"
export QT_QPA_PLATFORM="wayland"
export GEMINI_API_KEY="AIzaSyBfBkLzTelqgCZQK9f6NZXUxfpeIlqGuGc"
export PGDATA="/home/thatmagicalcat/postgres"

# weird bindgen pointer size mismatch pls go away
export BINDGEN_EXTRA_CLANG_ARGS="--target=x86_64-unknown-linux-gnu"

# Android stuff
export ANDROID_HOME="$HOME/Android/sdk"
export ANDROID_SDK_ROOT="$HOME/Android/sdk"

export RUSTC_WRAPPER=sccache
export FLYCTL_INSTALL="/home/thatmagicalcat/.fly"

export PATH="$PATH":"$HOME/Apps/bin"
export PATH="$PATH":"$HOME/.local/share/gem/ruby/3.4.0/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"$HOME/.emacs.d/bin"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
export PATH="$PATH":"$ANDROID_SDK_ROOT/cmdline-tools/latest"
export PATH="$PATH":"$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
export PATH="$PATH":"$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH":"$ANDROID_SDK_ROOT/emulator"
# export PATH="$PATH":"$HOME/Apps/zig-x86_64-linux-0.15.1"

set -p PATH ~/.cargo/bin
