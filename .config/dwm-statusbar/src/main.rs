mod blocks;

use blocks::*;
use dwm_statusbar::*;

fn main() {
    StatusBar::new(
        " | ",
        1,
        vec![
            blocks! {
                { |_| "windows: 1 -> status, 2 -> media, 3 -> misc".to_string(), 100 }
            },
            blocks! {
            //  { function         , update interval (ms) }
                { |_| String::new(), 1_000     }, // to add an extra `|` at the start
                { |_| cpu(), 5_000 },
                { |_| battery(), 20_000 },
                { |_| ram(), 10_000 },
                { |_| storage(), 60_000 },
                { |_| date(), 30_000 },
            },
            blocks! {
                { |_| media().unwrap_or_else(|| String::from("No media found")), 1000 },
            },
            blocks! {
                { |_| volume() , 100 },
                { |_| brtns() , 100 },
            },
        ],
    )
    .start();
}
