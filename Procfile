
A_PI: sleep 5; sox -V1 -t coreaudio "BlackHole 16ch" -t flac -C 0 -b 16 - remix 1 2 | nc 192.168.44.241 2150
PI_B: ssh pi-w 'nc -l 2150 | sox --input-buffer 10000000 -V1 -t flac - -t alsa hw:0'
B_PI: ssh pi-w 'sox --buffer 1000000 -V1 -t alsa hw:0 -t flac -C 0 -b 16 - | nc -l 2151'
PI_A: sleep 5; nc 192.168.44.241 2151 | sox --input-buffer 10000000 -V1 -t flac - -t coreaudio "BlackHole 16ch" remix 0 0 1 2