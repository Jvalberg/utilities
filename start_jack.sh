# /bin/bash

jack_control start
sudo schedtool -R -p 20 'pidof jackdbus'
jack_control eps realtime true
jack_control ds alsa
jack_control dps device hw:VSL
jack_control dps rate 48000
jack_control dps nperiods 2
jack_control dps period 64
sleep 10
qjackctl &
sleep 10
yoshimi -S &
sleep 10
