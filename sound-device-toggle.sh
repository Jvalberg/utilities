#! /bin/bash
# Toggle the sound device between PCH and HDMI
# Works by editing ~/.asoundrc config, and chaning parameters.
# newbie script which is most likely obosolete now, i use pulseaudio.
# CONSTANTS
HDMI="hw:0,7"
PCH="hw:1,0"

HDMI_CARD=0
HDMI_DEVICE=7
PCH_CARD=1
PCH_DEVICE=0

file="/home/jocke/.asoundrc"

function current_device
{
    ret=$PCH
    if grep -E -q ".*(card $HDMI_CARD)" $file; 
    then
	if grep -E -q ".*(device $HDMI_DEVICE)" $file;
	then
	    ret=$HDMI
	fi
    fi
    echo $ret
}


echo "Toggling default device..."

new_device_name="null"
new_card=-1
new_device=-1
current=$( current_device )
echo "$current"
if [ "$current" == "$HDMI" ]
then
    new_device_name="PCH"
    new_card=$PCH_CARD
    new_device=$PCH_DEVICE
else
    new_device_name="HDMI"
    new_card=$HDMI_CARD
    new_device=$HDMI_DEVICE
fi

echo "Default device is now $new_device_name"

echo "#ALSA Library configuration file" > $file
echo "#Include settings that are under control of asoundconf" >> $file
echo "</home/user/.asoundrc.asoundconf>" >> $file
echo "" >> $file
echo "# Sets the default device to $new_device_name" >> $file
echo "pcm.!default {" >> $file
echo "        type hw" >> $file
echo "        card $new_card" >> $file
echo "        device $new_device" >> $file
echo "}" >> $file
