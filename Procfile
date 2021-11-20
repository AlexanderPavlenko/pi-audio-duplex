host: PI_IP=apaw.local; sleep 0.5; sox -V1 --type coreaudio "RpIn" --type wav --rate 44100 --encoding signed-integer --bits 24 --channels 2 - | stdbuf -i0 -o0 nc $PI_IP 2150 | mpv --no-config --audio-device=coreaudio/RpOut_UID --profile=low-latency -
pi: ssh -S none root@pi 'killall -v -s SIGKILL nc arecord aplay; nice -n -20 arecord --verbose --disable-resample --disable-channels --disable-format --disable-softvol --mmap --nonblock --rate 44100 --format S24_3LE --channels 2 --file-type wav --device hw:CARD=UAC2Gadget,DEV=0 --buffer-time 100000 - | nice -n -20 stdbuf -i0 -o0 nc -l 2150 | nice -n -20 aplay --verbose --disable-resample --disable-channels --disable-format --disable-softvol --mmap --nonblock --rate 44100 --format S24_3LE --channels 2 --file-type wav --device hw:CARD=UAC2Gadget,DEV=0 --buffer-time 100000 -'

# sox alternatives:

# mpv -v --o=/dev/stdout --of=wav --oac=pcm_s24le av://avfoundation::RpIn
# fixme: [lavf] error reading packet: Resource temporarily unavailable.

# ffmpeg -f avfoundation -i ":RpIn" -f wav -c:a pcm_s24le -
# fixme: audio crackles