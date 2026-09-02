"""lab.sh 실행 로그에 필수 검증 결과가 모두 있는지 확인한다."""

from __future__ import annotations

import sys
from pathlib import Path

REQUIRED_MARKERS = [
    "=== LAB 01: ENVIRONMENT ===",
    "KERNEL=Linux",
    "MODE=755",
    "ERROR_COUNT=2",
    "UNIQUE_USERS=3",
    "ARCHIVE_SHA256=",
    "CHECKS_PASSED=8",
    "LAB_STATUS=PASS",
]


def verify(text: str) -> list[str]:
    return [marker for marker in REQUIRED_MARKERS if marker not in text]


def main() -> int:
    if len(sys.argv) != 2:
        print("usage: verify_output.py <terminal-output.txt>", file=sys.stderr)
        return 2
    path = Path(sys.argv[1])
    if not path.is_file():
        print(f"missing log: {path}", file=sys.stderr)
        return 2
    missing = verify(path.read_text(encoding="utf-8"))
    if missing:
        print("missing markers:")
        for marker in missing:
            print(f"- {marker}")
        return 1
    print(f"verification passed: {len(REQUIRED_MARKERS)} markers")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())


