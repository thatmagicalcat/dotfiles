{ pkgs ? import <nixpkgs> {} }:
pkgs.waydroid.overrideAttrs (old: {
  postPatch = (old.postPatch or "") + ''
    sed -i 's/LXC_USE_NFT="false"/LXC_USE_NFT="true"/' data/scripts/waydroid-net.sh
  '';
  postFixup = (old.postFixup or "") + ''
    wrapProgram $out/lib/waydroid/data/scripts/waydroid-net.sh \
      --prefix PATH ":" ${pkgs.lib.makeBinPath [ pkgs.nftables ]}
  '';
})
