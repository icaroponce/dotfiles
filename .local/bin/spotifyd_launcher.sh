killall -q spotifyd

while pgrep -u $UID -x spotifyd >/dev/null; do sleep 1; done

spotifyd

