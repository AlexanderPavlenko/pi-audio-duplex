host: sleep 3; sox -V1 -t coreaudio "BlackHole 16ch" -t wav -b 16 - remix 1 2 | nc 192.168.44.4 2150 | sox --input-buffer 500000 -V1 -t wav - -t coreaudio "BlackHole 16ch" remix 0 0 1 2
pi: trap 'ssh -S none root@pi "killall nc arecord aplay"' EXIT > /dev/null; ssh -S none root@pi 'nice -n -20 arecord --disable-resample --disable-channels --disable-format --disable-softvol --format S24_3LE --rate 44100 --channels 2 --file-type wav - | nice -n -20 nc -l 2150 -I 3000000 -O 3000000 | nice -n -20 aplay --disable-resample --disable-channels --disable-format --disable-softvol -'

# fixme: why sshd suddenly exits?
#ipad: trap 'ssh ipad "killall cat socat"' EXIT > /dev/null; ssh ipad ./pi-socat.sh