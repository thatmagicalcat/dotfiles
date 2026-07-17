{ pkgs, unstable, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    git
    swww
    kitty
    fish
    wget
    mako
    tree
    pywal
    starship
    zoxide
    pavucontrol
    lm_sensors
    fastfetch
    eza
    bat
    ripgrep
    grim
    wayshot
    slurp
    wl-clipboard
    sccache
    libnotify
    brightnessctl
    bc
    youtube-music
    copyq
    mpv
    eog
    imagemagick
    cava
    libqalculate
    clang
    gcc
    mold
    kdePackages.dolphin
    papirus-icon-theme
    arc-theme
    xdg-utils
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gnome
    xdg-desktop-portal
    shared-mime-info
    ffmpeg
    evil-helix
    lua
    sdl3
    yt-dlp
    python313
    python313Packages.ipykernel
    raylib
    cmake
    gnumake
    llvmPackages_21.clang-tools
    lldb
    # glfw3
    # wofi
    # fuzzel
    tofi
    qtscrcpy
    scrcpy
    ncdu
    zig
    zls
    # signal-desktop-bin
    wine
    wine64
    winetricks
    wineWowPackages.full
    tor-browser
    qpwgraph
    man-pages
    ani-cli
    osu-lazer-bin
    emacs
    file
    # maturin
    basedpyright
    pyrefly
    v4l-utils
    galculator
    easyeffects
    qt5.qtwayland
    pkgconf
    rofi
    tealdeer
    tmux
    btop
    sbcl
    rlwrap
    wasm-pack
    # ghostty
    waybar
    # neovide
    hyperfine
    inkscape
    gpu-screen-recorder-gtk
    flameshot
    alsa-lib
    vulkan-headers
    vulkan-loader
    vulkan-tools
    gemini-cli
    wlrctl
    unzip
    unrar-wrapper
    wgsl-analyzer
    zed-editor
    typescript-language-server
    bun
    # nodejs_24
    swaybg
    playerctl
    jq
    gnome-keyring
    pipes
    xwayland-satellite
    nasm
    fasm
    wtype
    keyd
    waydroid
    luarocks
    graphviz
    fd
    qemu
    grub2
    xorriso
    jujutsu
    zathura
    tinygo
    texlab
    fzf
    brotli
    sunshine
    nodejs_20
    rclone
    rclone-ui
    vesktop
    gh
    ormolu
    bubblewrap
    nil
    lua-language-server
    go
    obsidian
    telegram-desktop
    elan
    opencode

    (texlive.withPackages (ps: with ps; [
        scheme-basic
        darkmode
        latexmk
        latexindent
        # other packages
    ]))

    # inputs.ytm-player.packages.${system}.default
    inputs.zen-browser.packages."x86_64-linux".beta
    # inputs.nil.packages."x86_64-linux".default

    # unstable.voxtype
  ];

  qt.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.adb.enable = true;

  # programs.voxtype = {
    # enable = true;
    # package = inputs.voxtype.packages."x86_64-linux".onnx;
  # };

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        sed -i 's/LXC_USE_NFT="false"/LXC_USE_NFT="true"/' data/scripts/waydroid-net.sh
      '';
      postFixup = (old.postFixup or "") + ''
        wrapProgram $out/lib/waydroid/data/scripts/waydroid-net.sh \
          --prefix PATH ":" ${pkgs.lib.makeBinPath [ pkgs.nftables ]}
      '';
    });
  };

  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
