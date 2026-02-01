mod autostart;
mod binds;
mod input;
mod layout;
mod riverctl;
mod rules;
mod vars;
mod wal;

use anyhow::Result;
use wal::WalColors;

fn main() -> Result<()> {
    autostart::run()?;
    input::run()?;
    rules::run()?;
    binds::run()?;
    layout::run(&load_pywal_colors())?;

    Ok(())
}

fn load_pywal_colors() -> WalColors {
    WalColors::load().unwrap_or_else(|e| {
        eprintln!(
            "Warning: Could not load wal colors: {}. Using default fallback.",
            e
        );

        WalColors::load().unwrap_or_else(|_| panic!("Fatal: Could not initialize colors module"))
    })
}
