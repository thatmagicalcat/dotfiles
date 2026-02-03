use crate::riverctl::riverctl;
use crate::vars::*;

use anyhow::Result;

macro_rules! bind {
        ($mod:expr, $key:expr, $cmd:expr $(, $arg:expr)*) => {
            riverctl(&["map", "normal", &$mod, $key, $cmd $(, $arg)*])?;
        };
    }

macro_rules! ptr {
    ($mod:expr, $btn:expr, $action:expr) => {
        riverctl(&["map-pointer", "normal", &$mod, $btn, $action])?;
    };
}

pub fn run() -> Result<()> {
    let cfg = format!("{}/.config/river", std::env::var("HOME")?);

    let mod_shift = format!("{}+Shift", MOD);
    let mod_alt = format!("{}+{}", MOD, MOD2);
    let mod_alt_shift = format!("{}+{}+Shift", MOD, MOD2);
    let mod_alt_ctrl = format!("{}+{}+Control", MOD, MOD2);
    let mod_ctrl = format!("{}+Control", MOD);
    let mod_shift_ctrl = format!("{}+Shift+Control", MOD);

    // Core Mappings
    bind!(MOD, "Escape", "spawn", "systemctl suspend");
    bind!(MOD, "Return", "spawn", TERMINAL);
    bind!(mod_alt, "Return", "spawn", ALT_TERMINAL);

    bind!(MOD, "Space", "spawn", &format!("cd $HOME && {}", RUNNER));
    bind!(mod_alt, "E", "spawn", EMOJI);

    bind!(mod_shift, "C", "close");
    bind!(mod_shift, "E", "exit");

    // Navigation
    bind!(MOD, "J", "focus-view", "next");
    bind!(MOD, "K", "focus-view", "previous");
    bind!(mod_shift, "J", "swap", "next");
    bind!(mod_shift, "K", "swap", "previous");

    bind!(MOD, "0", "set-focused-tags", ALL_TAGS);
    bind!(mod_shift, "0", "set-view-tags", ALL_TAGS);

    // Directional Keys (H, J, K, L)
    for (key, dir) in [("H", "left"), ("J", "down"), ("K", "up"), ("L", "right")] {
        bind!(mod_alt, key, "move", dir, FACTOR);
        bind!(mod_alt_ctrl, key, "snap", dir);
    }

    // Resize
    bind!(
        mod_alt_shift,
        "H",
        "resize",
        "horizontal",
        &format!("-{}", FACTOR)
    );
    bind!(mod_alt_shift, "J", "resize", "vertical", FACTOR);
    bind!(
        mod_alt_shift,
        "K",
        "resize",
        "vertical",
        &format!("-{}", FACTOR)
    );
    bind!(mod_alt_shift, "L", "resize", "horizontal", FACTOR);

    // Tags 1-9
    for i in 1..=9 {
        let key = i.to_string();
        let tags = (1 << (i - 1)).to_string();
        bind!(MOD, &key, "set-focused-tags", &tags);
        bind!(mod_shift, &key, "set-view-tags", &tags);
        bind!(mod_ctrl, &key, "toggle-focused-tags", &tags);
        bind!(mod_shift_ctrl, &key, "toggle-view-tags", &tags);
    }

    // Pointers & Floating
    ptr!(MOD, "BTN_LEFT", "move-view");
    ptr!(MOD, "BTN_RIGHT", "resize-view");
    ptr!(MOD, "BTN_MIDDLE", "toggle-float");

    bind!(mod_shift, "Space", "toggle-float");
    bind!(MOD, "F", "toggle-fullscreen");

    // Modes
    riverctl(&["declare-mode", "passthrough"])?;
    bind!(MOD, "F11", "enter-mode", "passthrough");
    riverctl(&["map", "passthrough", MOD, "F11", "enter-mode", "normal"])?;

    // Scripts & Utilities
    bind!(MOD, "S", "spawn", &format!("sh {}/scripts/screenshot", cfg));
    bind!(mod_shift, "S", "spawn", "flameshot gui");
    bind!("None", "Print", "spawn", "sh -c 'grim - | wl-copy'");
    bind!(
        mod_shift,
        "W",
        "spawn",
        &format!("sh {}/scripts/wallpaper_selector.sh", cfg)
    );
    bind!(
        mod_shift,
        "E",
        "spawn",
        &format!("{}/scripts/easyeffects-toggle.sh", cfg)
    );

    // System
    bind!(MOD, "B", "spawn", "pkill -USR1 waybar");
    bind!(MOD, "R", "spawn", &format!("sh -c '{}/init compile'", cfg));

    // Voxtype
    bind!(MOD, "V", "spawn", "voxtype record start");
    riverctl(&[
        "map",
        "-release",
        "normal",
        MOD,
        "V",
        "spawn",
        "voxtype record stop",
    ])?;

    // Notifications
    bind!(mod_shift, "D", "spawn", "makoctl dismiss");
    bind!(mod_shift, "R", "spawn", "makoctl restore");

    // Media Controls
    let media_keys = [
        ("XF86AudioRaiseVolume", "volup.sh"),
        ("XF86AudioLowerVolume", "voldown.sh"),
        ("XF86AudioMute", "volmute.sh"),
        ("XF86MonBrightnessUp", "brtnsup.sh"),
        ("XF86MonBrightnessDown", "brtnsdown.sh"),
    ];

    for (key, script) in media_keys {
        bind!("None", key, "spawn", &format!("{}/scripts/{}", cfg, script));
    }

    bind!("None", "XF86AudioPlay", "spawn", "playerctl play-pause");
    bind!("None", "XF86AudioNext", "spawn", "playerctl next");
    bind!("None", "XF86AudioPrev", "spawn", "playerctl previous");
    bind!("None", "XF86AudioStop", "spawn", "playerctl stop");

    Ok(())
}
