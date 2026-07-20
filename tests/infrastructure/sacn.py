import threading
from collections.abc import Callable
from typing import Any

import sacn


class SacnReceiver:
    """Listens for sACN (E1.31) DMX data and stores the latest values per universe."""

    def __init__(self, bind_address: str = '0.0.0.0', bind_port: int = 5568):
        self._receiver: sacn.sACNreceiver = sacn.sACNreceiver(bind_address=bind_address, bind_port=bind_port)
        self._data: dict[int, tuple[int, ...]] = {}
        self._lock: threading.Lock = threading.Lock()

    def start(self):
        self._receiver.start()

    def stop(self):
        self._receiver.stop()

    def listen(self, universe: int):
        """Register a listener for the given universe."""
        self._receiver.register_listener('universe', self._make_callback(universe), universe=universe)
        self._receiver.join_multicast(universe)

    def _make_callback(self, universe: int) -> Callable[[Any], None]:
        def callback(packet: Any):
            if packet.dmxStartCode == 0x00:
                with self._lock:
                    self._data[universe] = packet.dmxData

        return callback

    def get_dmx_data(self, universe: int) -> tuple[int, ...] | None:
        """Return the latest DMX data tuple for a universe, or None if nothing received yet."""
        with self._lock:
            return self._data.get(universe)

    def get_channel_value(self, universe: int, channel: int) -> int | None:
        """Return the value for a single DMX channel (1-based), or None if no data."""
        data = self.get_dmx_data(universe)
        if data is None:
            return None
        index = channel - 1
        if index < 0 or index >= len(data):
            return None
        return data[index]
