wall_dir="${HOME}/Wallpaper/"
cache_dir="${HOME}/.cache/thumbnails/wal_selector"
# rofi_config_path="${HOME}/.config/rofi/wallpaper-sel.rasi"
# rofi_command="rofi -dmenu -config ${rofi_config_path} -theme-str ${rofi_override}"
wofi_command="wofi --show dmenu --allow-images"

if [ ! -d "${cache_dir}" ] ; then
    mkdir -p "${cache_dir}"
fi

for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
    if [ -f "$imagen" ]; then
        filename=$(basename "$imagen")
            if [ ! -f "${cache_dir}/${filename}" ] ; then
                magick convert -strip "$imagen" -thumbnail 500x500^ -gravity center -extent 500x500 "${cache_dir}/${filename}"
            fi
        fi
done

wall_selection=$(ls "$wall_dir" -t | rg 'jpg|png|jpeg' | while read -r A ; do  echo -en "$A\x00icon\x1f""${cache_dir}"/"$A\n" ; done | $wofi_command)

[[ -n "$wall_selection" ]] || exit 1

swww img "${wall_dir}${wall_selection}" -t center
wal -i "${wall_dir}${wall_selection}"

. "${HOME}/.config/river/init"
. "${HOME}/Scripts/update_mako_colors.sh"

exit 0
