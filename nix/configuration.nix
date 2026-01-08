{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.useTmpfs = true;
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "DELTA";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" ];

  time.timeZone = "Asia/Kolkata";
  documentation.man.generateCaches = false;

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.gvfs.enable = true;
  services.displayManager.ly.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  users.users.thatmagicalcat = {
    isNormalUser = true;
    description = "thatmagicalcat";
    extraGroups = [
      "networkmanager"
      "wheel"
      "seat"
    ];
    shell = pkgs.fish;
    packages = [ ];
  };

  security.rtkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    git
    # rustup
    # rust-analyzer
    swww
    kitty
    alacritty
    fish
    wget
    mako
    wideriver
    fish
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
    obs-studio
    copyq
    mpv
    eog
    imagemagick
    cava
    libqalculate
    clang
    gcc
    mold
    pcmanfm
    papirus-icon-theme
    arc-theme
    xdg-utils
    shared-mime-info
    ffmpeg
    evil-helix
    lua
    lua-language-server
    sdl3
    python314
    raylib
    cmake
    gnumake
    llvmPackages_21.clang-tools
    glfw3
    wofi
    fuzzel
    qtscrcpy
    ncdu
    zig
    zls
    signal-desktop-bin
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
    maturin
    basedpyright
    # haskell.compiler.ghc984Binary
    # ormolu
    # haskell-language-server
    v4l-utils
    docker
    galculator
    easyeffects
    qt5.qtwayland
    pkgconf
    rofi
    spotify
    tealdeer
    tmux
    btop
    sbcl
    rlwrap
    wasm-pack
    ghostty
    waybar
    neovide
    hyperfine
    inkscape

    inputs.zen-browser.packages."x86_64-linux".beta
    inputs.nil.packages."x86_64-linux".default
  ];

  programs.river-classic.enable = true;
  programs.river-classic.xwayland.enable = true;
  programs.niri.enable = true;
  programs.nix-ld.enable = true;
  programs.fish.enable = true;
  # programs.waybar.enable = true;
  programs.dconf.enable = true;
  # programs.obs-studio.enableVirtualCamera = true;
  programs.kdeconnect.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.blueman.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  systemd.services.battery-threshold = {
    description = "Set battery charge threshold";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.runtimeShell} -c 'echo 70 > /sys/class/power_supply/BAT0/charge_control_end_threshold'
      '';
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      mesa
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_LaserJet";
        location = "Home";
        deviceUri = "usb://HP/LaserJet%20M1005?serial=KJ6BBZB&interface=1";
        model = "drv:///hp/hpcups.drv/hp-laserjet_m1005.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05";
}
