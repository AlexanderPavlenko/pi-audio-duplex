#!/bin/sh
export JACK_NO_AUDIO_RESERVATION=1
exec jackd -P70 -p16 -t2000 -dalsa -p256 -n3 -r44100 -s -dhw:CARD=UAC2Gadget,DEV=0
