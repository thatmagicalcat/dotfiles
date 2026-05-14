{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.lilex
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    twemoji-color-font
    corefonts
    google-fonts
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
        "Liberation Serif"
        "Times New Roman"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
        "Liberation Sans"
        "Arial"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
        "Liberation Mono"
        "Courier New"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
