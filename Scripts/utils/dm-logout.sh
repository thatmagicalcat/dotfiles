#!/usr/bin/env sh

set -euo pipefail

_out="notify-send"
DMENU="dmenu -i -p"

output(){
    ${_out} "dm-logout" "$@"
}

main() {
    declare -a options=(
    "Logout"
    "Reboot"
    "Shutdown"
    "Suspend"
    "Quit"
    )

    choice=$(printf '%s\n' "${options[@]}" | ${DMENU} 'Power menu:' "${@}")

    case $choice in
        'Logout')
                if [[ "$(echo -e "No\nYes" | ${DMENU} "${choice}?" "${@}" )" == "Yes" ]]; then
                killall "dwm" || output "Process ${manager} was not running."
            else
                output "User chose not to logout." && exit 1
            fi
            ;;
        'Reboot')
            if [[ "$(echo -e "No\nYes" | ${DMENU} "${choice}?" "${@}" )" == "Yes" ]]; then
                systemctl reboot
            else
                output "User chose not to reboot." && exit 0
            fi
            ;;
        'Shutdown')
            if [[ "$(echo -e "No\nYes" | ${DMENU} "${choice}?" "${@}" )" == "Yes" ]]; then
                systemctl poweroff
            else
                output "User chose not to shutdown." && exit 0
            fi
            ;;
        'Suspend')
            if [[ "$(echo -e "No\nYes" | ${DMENU} "${choice}?" "${@}" )" == "Yes" ]]; then
                systemctl suspend
                else
                output "User chose not to suspend." && exit 0
            fi
            ;;
        'Quit')
            output "Program terminated." && exit 0
        ;;

        *)
            exit 0
        ;;
    esac

}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
