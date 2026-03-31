#!/usr/bin/env python3

import os
import subprocess
import sys
import time
from pathlib import Path
from typing import Optional


ROOT = Path(__file__).resolve().parent
PID_FILE = ROOT / ".server.pid"
LOG_FILE = Path("/tmp/trainings-tracker.log")
SERVER_SCRIPT = ROOT / "server.py"


def process_alive(pid: int) -> bool:
    try:
        os.kill(pid, 0)
        return True
    except OSError:
        return False


def read_pid() -> Optional[int]:
    try:
        value = PID_FILE.read_text(encoding="utf-8").strip()
        return int(value)
    except Exception:
        return None


def cleanup_stale_pid() -> None:
    pid = read_pid()
    if pid and process_alive(pid):
        print(pid)
        sys.exit(0)
    if PID_FILE.exists():
        PID_FILE.unlink()


def main() -> None:
    cleanup_stale_pid()
    with LOG_FILE.open("ab") as log_file:
        proc = subprocess.Popen(
            ["/usr/bin/python3", str(SERVER_SCRIPT)],
            cwd=str(ROOT),
            stdin=subprocess.DEVNULL,
            stdout=log_file,
            stderr=log_file,
            start_new_session=True,
        )
    PID_FILE.write_text(f"{proc.pid}\n", encoding="utf-8")
    time.sleep(1)
    if process_alive(proc.pid):
        print(proc.pid)
        return
    print("failed", file=sys.stderr)
    sys.exit(1)


if __name__ == "__main__":
    main()
