{ pkgs, inputs, ... }:

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
    shared-mime-info
    ffmpeg
    evil-helix
    lua
    sdl3
    python313
    python313Packages.ipykernel
    raylib
    cmake
    gnumake
    llvmPackages_21.clang-tools
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
    linux-manual
    ani-cli
    osu-lazer-bin
    emacs
    file
    # maturin
    basedpyright
    v4l-utils
    docker
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
    vesktop
    unzip
    unrar-wrapper
    wgsl-analyzer
    zed-editor
    typescript-language-server
    nodejs_24
    swaybg
    playerctl
    jq
    gnome-keyring
    pipes
    xwayland-satellite
    nasm
    fasm
    wtype
    vscode
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
    texlab
    (texlive.withPackages (ps: with ps; [
        scheme-basic
        darkmode
        latexmk
        latexindent
        # other packages
    ]))

    inputs.zen-browser.packages."x86_64-linux".beta
    # inputs.nil.packages."x86_64-linux".default
    inputs.opencode.legacyPackages."x86_64-linux".opencode
  ];

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
