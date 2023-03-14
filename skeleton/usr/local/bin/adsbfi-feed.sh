#!/bin/sh
while wait
do
    sleep 30 &
    /usr/bin/adsbfifeeder --quiet --net --net-only \
        --db-file=none --max-range 450 \
        --net-beast-reduce-interval 0.5 \
        --net-connector feed1.adsb.fi,30004,beast_reduce_out,feed2.adsb.fi,64004 \
        --net-connector 127.0.0.1,30005,beast_in \
        --net-ro-interval 0.2 --net-ri-port 0 --net-ro-port 0 \
        --net-sbs-port 0 --net-bi-port 0 --net-bo-port 0 \
        --json-location-accuracy 2 --write-json /run/adsbfi-feed \
        --lat $LATITUDE --lon $LONGITUDE
done
