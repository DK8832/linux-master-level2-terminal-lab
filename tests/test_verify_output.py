import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "src"))

from verify_output import REQUIRED_MARKERS, verify


class VerifyOutputTest(unittest.TestCase):
    def test_complete_log(self):
        self.assertEqual([], verify("\n".join(REQUIRED_MARKERS)))

    def test_reports_missing_marker(self):
        missing = verify("\n".join(REQUIRED_MARKERS[:-1]))
        self.assertEqual(["LAB_STATUS=PASS"], missing)

    def test_eight_required_markers(self):
        self.assertEqual(8, len(REQUIRED_MARKERS))


if __name__ == "__main__":
    unittest.main()


