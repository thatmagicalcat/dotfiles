use crate::riverctl::riverctl;
use anyhow::Result;

pub fn run() -> Result<()> {
    riverctl(&["rule-add", "-app-id", "zen-beta", "tags", "1"])?;
    riverctl(&["rule-add", "-app-id", "zen-beta", "csd"])?;
    riverctl(&["rule-add", "-app-id", "Spotify", "tags", &(1 << 4).to_string()])?;
    riverctl(&["rule-add", "-app-id", "vesktop", "tags", &(1 << 3).to_string()])?;
    Ok(())
}
