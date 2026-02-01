use anyhow::Result;
use std::collections::HashMap;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::path::Path;

pub struct WalColors {
    colors: HashMap<String, String>,
}

impl WalColors {
    pub fn load() -> Result<Self> {
        let home = std::env::var("HOME")?;
        let path = Path::new(&home).join(".cache/wal/colors.sh");
        let file = File::open(path)?;
        let reader = BufReader::new(file);
        let mut colors = HashMap::new();

        for line in reader.lines() {
            let line = line?;
            if line.contains('=') && !line.starts_with('#') && !line.starts_with("export") {
                let parts: Vec<&str> = line.splitn(2, '=').collect();
                if parts.len() == 2 {
                    let key = parts[0].trim().to_string();
                    let value = parts[1]
                        .trim()
                        .trim_matches('\'')
                        .trim_matches('"')
                        .to_string();
                    colors.insert(key, value);
                }
            }
        }

        Ok(WalColors { colors })
    }

    pub fn get(&self, name: &str) -> String {
        self.colors
            .get(name)
            .cloned()
            .unwrap_or_else(|| "#ffffff".to_string())
    }

    pub fn get_hex(&self, name: &str) -> String {
        let color = self.get(name);
        format!("0x{}", color.trim_start_matches('#'))
    }
}
