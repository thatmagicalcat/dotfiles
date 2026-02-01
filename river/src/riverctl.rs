use anyhow::{Context, Result};
use std::process::Command;

pub fn riverctl(args: &[&str]) -> Result<()> {
    Command::new("riverctl")
        .args(args)
        .status()
        .with_context(|| format!("Failed to execute riverctl {:?}", args))?;
    Ok(())
}

pub fn spawn(cmd: &str) -> Result<()> {
    Command::new("sh")
        .arg("-c")
        .arg(cmd)
        .spawn()
        .with_context(|| format!("Failed to spawn command: {}", cmd))?;
    Ok(())
}

pub fn run_cmd(cmd: &str) -> Result<()> {
    Command::new("sh")
        .arg("-c")
        .arg(cmd)
        .status()
        .with_context(|| format!("Failed to run command: {}", cmd))?;
    Ok(())
}
