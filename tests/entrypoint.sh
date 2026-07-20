#!/usr/bin/env bash
set -euo pipefail

# Create empty .Xauthority so python-xlib doesn't fail on import
touch "${HOME}/.Xauthority"

# Start Xvfb (headless X server) first — other daemons need DISPLAY
Xvfb :99 -screen 0 "${XVFB_RESOLUTION}" -dpi 96 -ac +extension GLX +render -noreset &
XVFB_PID=$!

# Wait for the X server to be ready
for i in $(seq 1 30); do
    if xdpyinfo -display :99 >/dev/null 2>&1; then
        break
    fi
    sleep 0.1
done

# Start D-Bus session bus (required for AT-SPI / dogtail)
if [ -z "${DBUS_SESSION_BUS_PID:-}" ]; then
    eval "$(dbus-launch --sh-syntax)"
    export DBUS_SESSION_BUS_ADDRESS
    export DBUS_SESSION_BUS_PID
fi

# Start the AT-SPI registry daemon (needs both DISPLAY and D-Bus)
/usr/libexec/at-spi2-registryd &
sleep 0.5

# Enable AT-SPI accessibility on the bus
export GTK_MODULES="gail:atk-bridge"
export NO_AT_BRIDGE=0

# Execute the test command
exec "$@"
