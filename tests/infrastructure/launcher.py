import os
import shutil
import subprocess
import tempfile
import types
import zipfile
from time import sleep

from dogtail import rawinput


def _maximize_window(name: str, retries: int = 10):
    """Resize the window matching *name* to fill the entire screen.

    Uses python-xlib directly so this works in bare Xvfb without a
    window manager (where keyboard shortcuts like Super+F are no-ops).
    """
    import Xlib.display
    import Xlib.X

    display = Xlib.display.Display()
    root = display.screen().root
    screen_width = display.screen().width_in_pixels
    screen_height = display.screen().height_in_pixels

    def _find(parent):
        for child in parent.query_tree().children:
            wm_name = child.get_wm_name()
            if wm_name and name in wm_name:
                return child
            found = _find(child)
            if found:
                return found
        return None

    for _ in range(retries):
        win = _find(root)
        if win is not None:
            win.configure(
                x=0,
                y=0,
                width=screen_width,
                height=screen_height,
                stack_mode=Xlib.X.Above,
            )
            display.sync()
            return
        sleep(0.5)

    print(f"Warning: could not find window '{name}' to maximize")


class Mizer:
    def __init__(self):
        self.tempdir: str = tempfile.mkdtemp(prefix='mizer-', suffix='-e2e')
        self.proc: subprocess.Popen[bytes] | None = None
        self._log_file = None

    def __enter__(self) -> 'Mizer':
        self.extract()
        return self

    def __exit__(
        self,
        exc_type: type[BaseException] | None,
        exc_value: BaseException | None,
        traceback: types.TracebackType | None,
    ):
        self.cleanup()

    @property
    def log_path(self) -> str:
        return os.path.join(self.tempdir, 'mizer.log')

    def start(self, project: str | None):
        self.stop()
        work = self.tempdir
        args = [f'{work}/mizer']
        if project:
            cwd = os.getcwd()
            project_path = os.path.normpath(f'{cwd}/{project}')
            print(f"Opening project {project_path}")
            args.append(project_path)
        self._log_file = open(self.log_path, 'w')
        self.proc = subprocess.Popen(args, cwd=work, stdout=self._log_file, stderr=subprocess.STDOUT)
        sleep(1)
        _maximize_window('Mizer')

    def stop(self):
        if self.proc:
            self.proc.kill()
            self.proc.wait()
            self.proc = None
        if self._log_file:
            self._log_file.close()
            self._log_file = None

    def extract(self):
        with zipfile.ZipFile('../mizer.zip', 'r') as zip_ref:
            for info in zip_ref.infolist():
                extract_file(zip_ref, info, self.tempdir)

    def cleanup(self):
        self.stop()
        shutil.rmtree(self.tempdir)


def extract_file(zf: zipfile.ZipFile, info: zipfile.ZipInfo, extract_dir: str):
    zf.extract(info.filename, path=extract_dir)
    out_path = os.path.join(extract_dir, info.filename)

    perm = info.external_attr >> 16
    os.chmod(out_path, perm)
