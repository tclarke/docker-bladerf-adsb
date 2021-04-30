#!/bin/sh

echo /src/dump1090/dump1090 --net-only --raw
/src/dump1090/dump1090 --net-only --raw &
sleep 3
echo /src/bladeRF-adsb/bladeRF_adsb/bladeRF_adsb max
/src/bladeRF-adsb/bladeRF_adsb/bladeRF_adsb max
