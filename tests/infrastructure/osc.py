import threading
import time
from typing import Any

from pythonosc.dispatcher import Dispatcher
from pythonosc.osc_server import ThreadingOSCUDPServer


class OscReceiver:
    """Listens for OSC messages and stores the latest values per address path."""

    def __init__(self):
        self._data: dict[str, tuple[Any, ...]] = {}
        self._log: list[str] = []
        self._lock: threading.Lock = threading.Lock()
        self._server: ThreadingOSCUDPServer | None = None
        self._thread: threading.Thread | None = None

    def _handler(self, address: str, *args: Any):
        print(f"Received OSC message for address '{address}' with {len(args)} arguments")
        with self._lock:
            self._data[address] = args
            self._log.append(f"[{time.monotonic():.3f}] {address} {args}")

    def start(self, port: int, host: str = '0.0.0.0'):
        dispatcher = Dispatcher()
        dispatcher.set_default_handler(self._handler)
        self._server = ThreadingOSCUDPServer((host, port), dispatcher)
        self._thread = threading.Thread(target=self._server.serve_forever, daemon=True)
        self._thread.start()

    def stop(self):
        if self._server:
            self._server.shutdown()
            self._server.server_close()
        if self._thread:
            self._thread.join(timeout=2)
            if self._thread.is_alive():
                raise RuntimeError('OSC server thread did not stop')
            self._thread = None

    def get_message(self, address: str) -> tuple[Any, ...] | None:
        """Return the latest argument tuple for an OSC address, or None if nothing received."""
        with self._lock:
            return self._data.get(address)

    def get_value(self, address: str, index: int = 0) -> Any | None:
        """Return a single argument value from the latest message at an address."""
        args = self.get_message(address)
        if args is None or index >= len(args):
            return None
        return args[index]

    def get_log(self) -> str:
        """Return all received messages as a newline-separated string."""
        with self._lock:
            return '\n'.join(self._log)
