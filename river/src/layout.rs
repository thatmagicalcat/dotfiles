use crate::riverctl::{riverctl, run_cmd, spawn};
use crate::vars::*;
use crate::wal::WalColors;

use anyhow::Result;

pub fn run(colors: &WalColors) -> Result<()> {
    riverctl(&["default-layout", "wideriver"])?;

    // Ignore error if pkill fails (e.g. process not found)
    _ = run_cmd("pkill wideriver");

    let focused_color = colors.get_hex("color10");
    let unfocused_color = colors.get_hex("color0");

    let wideriver_cmd = format!(
        "wideriver \
        --layout left \
        --layout-alt monocle \
        --stack dwindle \
        --count-master 1 \
        --ratio-master 0.50 \
        --count-wide-left 0 \
        --ratio-wide 0.3 \
        --no-smart-gaps \
        --inner-gaps 10 \
        --outer-gaps 10 \
        --border-width 2 \
        --border-width-monocle 0 \
        --border-width-smart-gaps 0 \
        --border-color-focused \"{}\" \
        --border-color-focused-monocle \"0x586e75\" \
        --border-color-unfocused \"{}\" \
        --log-threshold info \
        > \"/tmp/wideriver.log\" 2>&1 &",
        focused_color, unfocused_color
    );

    spawn(&wideriver_cmd)?;

    // Layout binds
    let cmds = [
        ("up", "--layout monocle"),
        ("down", "--layout wide"),
        ("left", "--layout left"),
        ("right", "--layout right"),
        ("M", "--layout-toggle"),
        ("L", "--ratio +0.025"),
        ("H", "--ratio -0.025"),
        ("E", "--stack even"),
        ("W", "--stack dwindle"),
        ("I", "--stack diminish"),
    ];

    for (combo, arg) in cmds {
        riverctl(&["map", "normal", MOD, combo, "send-layout-cmd", "wideriver", arg])?;
    }

    Ok(())
}
