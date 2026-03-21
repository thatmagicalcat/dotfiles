use crate::riverctl::spawn;
use anyhow::Result;
use std::fs;
use std::path::Path;

pub fn run() -> Result<()> {
    let lockfile = "/tmp/river-autostart.lock";

    if !Path::new(lockfile).exists() {
        fs::File::create(lockfile)?;

        spawn("systemctl --user import-environment WAYLAND_DISPLAY DISPLAY XDG_CURRENT_DESKTOP")?;
        spawn("systemctl --user restart xdg-desktop-portal-gtk.service")?;

        for app in [
            "swww-daemon",
            "mako",
            "copyq --start-server",
            "waybar",
            "kdeconnect-indicator",
            "alacritty --daemon",
        ] {
            spawn(&format!("{} &", app))?;
        }
    }

    Ok(())
}
