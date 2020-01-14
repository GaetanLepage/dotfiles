#!/bin/sh

HOSTNAME=$(hostname)
echo "detected system : "$HOSTNAME

disable_all () {
    xrandr --output eDP1 --off
    xrandr --output DP1 --off
    xrandr --output DP1-1 --off
    xrandr --output DP1-3 --off
    xrandr --output DP2 --off
    xrandr --output DP2-2 --off
    xrandr --output DP2-3 --off
    xrandr --output VIRTUAL1 --off
}

dual_screen () {
    xrandr --output $BENQ --mode 1920x1080 --pos 0x0 --rotate normal --output $S144 --mode 1920x1080 --rate 144 --primary --pos 1920x0 --rotate normal
}

is_connected() {
    # $1 : name of an output

    # Check if the display is connected or not
    STATE=$(xrandr | grep -oP '(?<=\b'$1'\s)\w+')

    echo $1 is ${STATE}

    if [ "$STATE" == "connected" ]
    then
        return 0
    elif [ "$STATE" == "disconnected" ]
    then
        return 1
    fi

    return 1

}


# Start by disabling all outputs
disable_all


case $HOSTNAME in
    # Desktop PC
    gaetan-pc)

        S144="DP-0"
        BENQ="DVI-D-0"
        dual_screen
        ;;

    # Laptop
    gaetan-xps)
        LAPTOP_SCREEN="eDP1"
        EXTERNAL="DP1"
        S144="DP1-2"
        BENQ="DP2-1"

        # Dual screen (TB3 dock)
        if is_connected "$S144" && is_connected "$BENQ";
        then
            echo "Dual screen"
            dual_screen

            # Turn wifi off
            nmcli radio wifi off

        # External only
        elif is_connected "$EXTERNAL";
        then
            echo "Single external screen"
            xrandr --output "$EXTERNAL" --mode 1920x1080 --pos 0x0 --rotate normal

        # Laptop only
        elif is_connected "$LAPTOP_SCREEN";
        then
            echo "laptop screen only"
            xrandr --output "$LAPTOP_SCREEN" --mode 1920x1080 --pos 0x0 --rotate normal

            # start wifi
            nmcli radio wifi on

        fi

        ;;
esac
