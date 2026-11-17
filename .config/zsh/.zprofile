# Login shell. On tty1 (Linux console) start X right away; does nothing on the Mac or in X.
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ] && command -v startx >/dev/null; then
  exec startx
fi
