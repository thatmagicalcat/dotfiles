use crate::riverctl::{riverctl, spawn};
use crate::vars::*;
use crate::wal::WalColors;

use anyhow::Result;

pub fn run(colors: &WalColors) -> Result<()> {
    riverctl(&["default-layout", "wideriver"])?;
    spawn("pkill wideriver")?;

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
        (format!("{}+up", MOD), "--layout monocle"),
        (format!("{}+down", MOD), "--layout wide"),
        (format!("{}+left", MOD), "--layout left"),
        (format!("{}+right", MOD), "--layout right"),
        (format!("{}+M", MOD), "--layout-toggle"),
        (format!("{}+L", MOD), "--ratio +0.025"),
        (format!("{}+H", MOD), "--ratio -0.025"),
        (format!("{}+E", MOD), "--stack even"),
        (format!("{}+W", MOD), "--stack dwindle"),
        (format!("{}+I", MOD), "--stack diminish"),
    ];

    for (combo, arg) in cmds {
        riverctl(&["map", "normal", &combo, "send-layout-cmd", "wideriver", arg])?;
    }

    Ok(())
}
