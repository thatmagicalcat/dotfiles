use crate::riverctl::riverctl;
use anyhow::Result;

pub fn run() -> Result<()> {
    riverctl(&["rule-add", "-app-id", "zen", "tags", "1"])?;
    Ok(())
}
