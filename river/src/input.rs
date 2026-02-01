use crate::riverctl::riverctl;
use crate::vars::*;
use anyhow::Result;

pub fn run() -> Result<()> {
    riverctl(&["input", TRACKPAD, "scroll-method", "two-finger"])?;
    riverctl(&["input", MOUSE, "accel-profile", "flat"])?;
    riverctl(&["input", MOUSE, "pointer-accel", "0.0"])?;
    riverctl(&["input", TRACKPAD, "tap-button-map", "left-right-middle"])?;
    riverctl(&["input", TRACKPAD, "tap", "enabled"])?;

    riverctl(&["set-repeat", "50", "300"])?;

    Ok(())
}
