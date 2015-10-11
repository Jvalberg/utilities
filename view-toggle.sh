# !/bin/bash
# A script which toggles what screens, and how to use them
# Looks at what monitors are existing and used, and uses this to toggle.

# Constants, HDMI=HDMI2 is known by experiments
LAPTOP="eDP1"
HDMI="HDMI2" 

if xrandr | grep -q -E "$HDMI connected";
then
    echo "HDMI is connected."
    echo "Toggling between not showing and placing to the right"
    if xrandr | grep -q -E "$HDMI.*([0-9]{3,4}x[0-9]{3,4})";
    then
	# HDMI is active
	xrandr --output $LAPTOP --auto --primary --output $HDMI --off
    else
	xrandr --output $LAPTOP --auto --primary --output $HDMI --auto --right-of $LAPTOP
    fi
else
    echo "HDMI is disconnected"
    xrandr --output $LAPTOP --auto --primary --output $HDMI --off
fi

