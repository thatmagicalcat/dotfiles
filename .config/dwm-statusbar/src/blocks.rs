use cmd_lib::run_fun as run;
use std::array::from_fn;

// brightness
pub fn brtns() -> Option<String> {
    Some(format!(
        "brightness: {}",
        run! { brightnessctl i }.ok()?.split(['(', ')']).nth(1)?
    ))
}

pub fn volume() -> Option<String> {
    Some(format!(
        "volume: {}",
        run! { amixer get PCM }
            .ok()?
            .lines()
            .nth(5)?
            .split(' ')
            .nth(6)?
            .trim_matches(['[', ']'])
    ))
}

pub fn ram() -> Option<String> {
    let out = run! { free -h }.ok()?;
    let mem_line = out.lines().nth(1)?;
    let mut split = mem_line.split(' ').filter(|i| !i.is_empty()).skip(1);
    let [total, used] = from_fn(|_| split.next().unwrap());

    Some(format!(
        " {}/{}",
        used.replace("i", "B"),
        total.replace("i", "B")
    ))
}

pub fn battery() -> Option<String> {
    let acpi_out = run! { acpi - b }.ok()?;
    let mut split = acpi_out.split([',', ':']);

    let status = split.nth(1)?.trim();
    let percentage = split.next()?.trim();
    let n = percentage.trim_end_matches('%').parse::<u8>().ok()?;
    let indicator = if status == "Charging" {
        ""
    } else if n >= 75 {
        ""
    } else if n >= 50 {
        ""
    } else if n >= 25 {
        ""
    } else {
        ""
    };

    Some(format!("{indicator}  {percentage}"))
}

pub fn storage() -> Option<String> {
    let drives = ["/", "/home"];

    Some(
        drives
            .iter()
            .filter_map(|path| {
                let x = run! { df -h --output=used,size,pcent $path }.ok()?;
                let mut split = x.lines().nth(1)?.split(" ").filter(|i| !i.is_empty());

                let [used, total] = from_fn(|_| split.next().unwrap());
                let [used, total] = [&used[..used.len() - 1], &total[..total.len() - 1]];

                Some(format!("{path}: {used}/{total} GB "))
            })
            .collect(),
    )
}

pub fn date() -> Option<String> {
    run! { date +"%a, %b %d %I:%M %P" }.ok()
}

pub fn cpu() -> Option<String> {
    Some(format!(
        "  {}% 󰏈 {}C 󰈐 {} RPM",
        cpu_percentage()?,
        cpu_temp()?,
        cpu_fan_speed()?
    ))
}

fn cpu_temp() -> Option<String> {
    Some(
        run! { sensors }
            .ok()?
            .lines()
            .find(|i| i.starts_with("Package id 0"))
            .unwrap()
            .split(" ")
            .filter(|i| !i.is_empty())
            .nth(3)?
            .trim_matches(['+', '.', 'C', ' '])
            .trim_end_matches(".0")
            .to_string(),
    )
}

fn cpu_fan_speed() -> Option<String> {
    Some(
        run! { sensors | grep cpu_fan }
            .ok()?
            .rsplit(' ')
            .nth(1)?
            .to_string(),
    )
}

fn cpu_percentage() -> Option<u32> {
    let f = || -> Option<(u32, u32)> {
        let out = std::fs::read_to_string("/proc/stat").ok()?;
        let mut split = out[5..].split(' ');

        let total = split
            .clone()
            .filter(|i| !i.is_empty())
            .take(3)
            .map(|i| i.parse::<u32>().unwrap())
            .sum::<u32>();
        let idle = split.nth(3).unwrap().parse::<u32>().ok()?;

        Some((total + idle, idle))
    };

    let (previous_total, previous_idle) = f()?;
    std::thread::sleep(std::time::Duration::from_millis(500));
    let (total, idle) = f()?;

    Some(100 * ((total - previous_total) - (idle - previous_idle)) / (total - previous_total))
}

pub fn media() -> Option<String> {
    let status = run! { playerctl status -a }.ok()?;
    let players = run! { playerctl metadata -a -f "{{playerName}}" }.ok()?;
    let artists = run! { playerctl metadata -a -f "{{trunc(artist, 30)}}" }.ok()?;
    let titles = run! { playerctl metadata -a -f "{{trunc(title, 30)}}" }.ok()?;
    let positions = run! {
        playerctl metadata -a -f "{{duration(position)}} / {{duration(mpris:length)}}"
    }
    .ok()?;

    let status = status.lines();
    let mut players = players.lines();
    let mut artists = artists.lines();
    let mut titles = titles.lines();
    let mut positions = positions.lines();

    let mut out = vec![];
    for status in status {
        let player = players.next().unwrap_or("unknown player");
        let artist = artists
            .next()
            .map(|i| format!(" - {i}"))
            .unwrap_or_else(|| "".to_string());
        let title = titles.next().unwrap_or("no title");
        let position = positions.next().unwrap_or("--:--");
        let indicator = if status == "Playing" { "" } else { "" };

        out.push(format!(
            "{player}: {indicator} {title}{artist} [{position}]"
        ));
    }

    Some(out.join(" | "))
}
