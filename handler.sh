#!/bin/bash
# Default acpi script that takes an entry for all actions
# /etc/acpi/handler.sh

case "$1" in
    button/power)
        case "$2" in
            PBTN|PWRF)
                logger 'PowerButton pressed'
		DISPLAY=:0.0 su catherine -c "/usr/bin/i3lock -c 2a2a2a"
		echo -n mem > /sys/power/state
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    button/sleep)
        case "$2" in
            SLPB|SBTN)
                logger 'SleepButton pressed'
		DISPLAY=:0.0 su catherine -c "/usr/bin/i3lock -c 2a2a2a"
		echo -n mem > /sys/power/state
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    ac_adapter)
        case "$2" in
            AC|ACAD|ADP0)
                case "$4" in
                    00000000)
                        logger 'AC unpluged'
                        ;;
                    00000001)
                        logger 'AC pluged'
                        ;;
                esac
                ;;
            *)
                logger "ACPI action undefined: $2"
                ;;
        esac
        ;;
    battery)
        case "$2" in
            BAT0)
                case "$4" in
                    00000000)
                        logger 'Battery online'
                        ;;
                    00000001)
                        logger 'Battery offline'
                        ;;
                esac
                ;;
            CPU0)
                ;;
            *)  logger "ACPI action undefined: $2" ;;
        esac
        ;;
    button/lid)
        case "$3" in
            close)
                logger 'LID closed'
		DISPLAY=:0.0 su catherine -c "/usr/bin/i3lock -c 2a2a2a"
		echo -n mem > /sys/power/state
                ;;
            open)
                logger 'LID opened'
                ;;
            *)
                logger "ACPI action undefined: $3"
                ;;
        esac
        ;;

    # Begin custom setings
	video/brightnessdown)
		case $2 in
			BRTDN)
				logger 'Brightness decreased'
				b1_dev=/sys/class/backlight/intel_backlight
				b1_new=$(($(< $b1_dev/brightness) - 50))
				if (($b1_new < 0));
					then b1_new=0;
				fi
				echo $b1_new >$b1_dev/brightness
				;;
			*)
				logger "ACPI action undefined: $2" ;;
		esac
		;;
	video/brightnessup)
		case $2 in
			BRTUP)
				logger 'Brightness increased'
				b1_dev=/sys/class/backlight/intel_backlight
				b1_new=$(($(< $b1_dev/brightness) + 50))
				b1_max=$(< $b1_dev/max_brightness)
				if (($b1_new > $b1_max));
					then b1_new=$b1_max;
				fi
				echo $b1_new >$b1_dev/brightness
				;;
			*)
				logger "ACPI action undefined: $2" ;;
		esac
		;;
	button/volumeup)
		case $2 in
			VOLUP)
				logger 'Volume increased'
				amixer -c 1 set Master 5+
				;;
			*)
				logger "ACPI action undefined: $2" ;;
		esac
		;;
	button/volumedown)
		case $2 in
			VOLDN)
				logger 'Volume decreased'
				amixer -c 1 set Master 5-
				;;
			*)
				logger "ACPI action undefined: $2" ;;
		esac
		;;
	button/mute)
		case $2 in
			MUTE)
				logger 'Volume muted/unmuted'
				amixer -c 1 set Master toggle
				;;
			*)
				logger "ACPI action undefined: $2" ;;
		esac
		;;
    # End custom settings

    *)
        logger "ACPI group/action undefined: $1 / $2"
        ;;
esac

# vim:set ts=4 sw=4 ft=sh et:
