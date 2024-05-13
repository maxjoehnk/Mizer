import os
import shutil
import subprocess
import tempfile
import zipfile


class Mizer:
    tempdir = None
    proc = None

    def __init__(self):
        self.tempdir = tempfile.mkdtemp(prefix='mizer-', suffix='-e2e')

    def __enter__(self):
        self.extract()
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.cleanup()

    def start(self, project: str | None):
        work = self.tempdir
        args = [f'{work}/mizer']
        if project:
            cwd = os.getcwd()
            project_path = os.path.normpath(f'{cwd}/../{project}')
            print(f"Opening project {project_path}")
            args.append(project_path)
        self.proc = subprocess.Popen(args, cwd=work)

    def stop(self):
        if self.proc:
            self.proc.kill()
            self.proc.wait()
            self.proc = None

    def extract(self):
        with zipfile.ZipFile('../mizer.zip', 'r') as zip_ref:
            for info in zip_ref.infolist():
                extract_file(zip_ref, info, self.tempdir)

    def cleanup(self):
        self.stop()
        shutil.rmtree(self.tempdir)


def extract_file(zf, info, extract_dir):
    zf.extract(info.filename, path=extract_dir)
    out_path = os.path.join(extract_dir, info.filename)

    perm = info.external_attr >> 16
    os.chmod(out_path, perm)
