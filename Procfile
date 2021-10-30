host: PI_IP=apaw.local; sleep 3; sox -V1 -t coreaudio "BlackHole 16ch" -t wav -b 24 - remix 1 2 | nc $PI_IP 2150 | sox -V1 -t wav - -t coreaudio "BlackHole 2ch"
pi: trap 'ssh -S none root@pi "killall nc arecord aplay"' EXIT > /dev/null; ssh -S none root@pi 'nice -n -20 arecord --verbose --disable-resample --disable-channels --disable-format --disable-softvol --mmap --nonblock --format S24_3LE --rate 44100 --channels 2 --file-type wav - | nice -n -20 nc -l 2150 | nice -n -20 aplay --verbose --disable-resample --disable-channels --disable-format --disable-softvol --mmap --nonblock -'

# fixme: why sshd suddenly exits?
#ipad: trap 'ssh ipad "killall cat socat"' EXIT > /dev/null; ssh ipad ./pi-socat.sh