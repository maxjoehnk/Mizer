import base64
import json
import os
import subprocess
import time
from pathlib import Path

import cv2
import dogtail.tree
import numpy as np
from dogtail import rawinput
from dogtail.config import config
from dogtail.tree import Node

config.search_showing_only = False

APP_NAME = 'mizer'


def get_app() -> Node:
    """Find and return the mizer application node in the accessibility tree."""
    return dogtail.tree.root.application(APP_NAME)


def _find_by_name(parent: Node, text: str, partial: bool = False, retry: bool = True) -> Node:
    """Find a descendant by name, with optional partial matching."""
    if partial:
        return parent.findChild(
            lambda node: text in (node.name or ''),
            retry=retry,
        )
    return parent.child(name=text, retry=retry)


def click_on_text(text: str, partial: bool = False):
    """Find an element by its accessible name and activate it via AT-SPI action."""
    app = get_app()
    element = _find_by_name(app, text, partial)
    # element.do_action(0)
    element.do_action_named('Tap')


def find_element(name: str, role: str | None = None, partial: bool = False) -> Node:
    """Find an element by name and optionally by role."""
    app = get_app()
    if partial or role:
        return app.findChild(
            lambda node: (name in (node.name or '') if partial else name == node.name)
            and (role is None or role == node.role_name),
        )
    return app.child(name=name)


def element_exists(name: str, role: str | None = None, partial: bool = False) -> bool:
    """Check if an element exists in the accessibility tree."""
    app = get_app()
    try:
        if partial or role:
            app.findChild(
                lambda node: (name in (node.name or '') if partial else name == node.name)
                and (role is None or role == node.role_name),
                retry=False,
            )
        else:
            app.child(name=name, retry=False)
        return True
    except dogtail.tree.SearchError:
        return False


def get_window_center() -> tuple[int, int]:
    """Get the center coordinates of the application window."""
    app = get_app()
    window = app.children[0]
    pos = window.position
    size = window.size
    return pos[0] + size[0] // 2, pos[1] + size[1] // 2


def move_to_center():
    """Move mouse to the center of the application window."""
    x, y = get_window_center()
    rawinput.absoluteMotion(x, y)


def scroll_at(x: int, y: int, clicks: int):
    """Scroll at position. Positive clicks = up, negative = down."""
    button = 4 if clicks > 0 else 5
    for _ in range(abs(clicks)):
        rawinput.click(x, y, button=button)


def enter_text_into_field(text: str, field_name: str):
    """Find a text field by name, focus it, clear it, and type the given text."""
    element = find_element(field_name, role='text')
    element.do_action_named('Focus')
    # element.click()
    rawinput.keyCombo('<Control>a')
    rawinput.typeText(text)


def take_screenshot(file: str):
    """Take a screenshot of the focused window and save it to the given file path."""
    subprocess.run(['scrot', '-o', '-u', file], check=True)


def _take_screenshot_as_image(result_path: str) -> np.ndarray | None:
    """Capture the full screen, save it to result_path, and return it as a cv2 image.

    Always captures the full screen instead of the focused window because
    template matching searches for the reference within the screenshot anyway,
    and scrot -u is unreliable in bare Xvfb without a window manager (it can
    succeed but capture the root window instead of the application).
    """
    try:
        subprocess.run(['scrot', '-o', result_path], check=True)
    except subprocess.CalledProcessError:
        return None
    return cv2.imread(result_path)


def _match_snapshot(screenshot: np.ndarray, reference: np.ndarray, threshold: float) -> tuple[float, tuple[int, int]]:
    """Find the best template match and return (score, location)."""
    result = cv2.matchTemplate(screenshot, reference, cv2.TM_CCOEFF_NORMED)
    _, max_val, _, max_loc = cv2.minMaxLoc(result)
    return max_val, max_loc


def assert_snapshot(snapshot_name: str, timeout: float = 5.0, threshold: float = 0.8):
    """Assert that the reference snapshot is visible on screen.

    Repeatedly takes screenshots and uses cv2 template matching to find the
    reference snapshot. Retries until the match score exceeds the threshold
    or the timeout expires.
    On failure, attaches expected/actual/diff images to the Allure report.
    """

    result_path = f'results/screenshots/{snapshot_name}.png'
    reference_path = f'snapshots/{snapshot_name}.png'

    if not os.path.exists(reference_path):
        raise FileNotFoundError(
            f'Reference snapshot not found: {reference_path}. '
            f'Screenshot saved to {result_path}. '
            f'To create the baseline, copy the result: cp {result_path} {reference_path}'
        )

    os.makedirs(os.path.dirname(result_path), exist_ok=True)

    reference = cv2.imread(reference_path)
    if reference is None:
        raise FileNotFoundError(f'Could not read reference snapshot: {reference_path}')

    deadline = time.monotonic() + timeout
    best_score = -1.0
    best_loc = (0, 0)
    screenshot = None

    while True:
        screenshot = _take_screenshot_as_image(result_path)
        if screenshot is not None:
            score, loc = _match_snapshot(screenshot, reference, threshold)
            if score > best_score:
                best_score = score
                best_loc = loc
            if score >= threshold:
                return

        if time.monotonic() >= deadline:
            break
        time.sleep(0.5)

    _attach_snapshot_diff(reference, screenshot, best_loc, snapshot_name)

    assert False, (
        f'Snapshot "{snapshot_name}" not found on screen (best score: {best_score:.3f}, '
        f'threshold: {threshold}). '
        f'Screenshot saved to {result_path} for comparison with {reference_path}'
    )


def _attach_snapshot_diff(
    reference: np.ndarray,
    screenshot: np.ndarray | None,
    best_loc: tuple[int, int],
    name: str,
):
    """Attach expected, actual (best-match crop), and diff images to Allure."""
    import allure

    try:
        if reference is None or screenshot is None:
            return

        h, w = reference.shape[:2]
        x, y = best_loc
        crop = screenshot[y:y + h, x:x + w]
        diff = cv2.absdiff(reference, crop)

        diff_dir = 'results/screenshots/diffs'
        os.makedirs(diff_dir, exist_ok=True)
        reference_path = f'{diff_dir}/{name}_expected.png'
        actual_path = f'{diff_dir}/{name}_actual.png'
        diff_path = f'{diff_dir}/{name}_diff.png'

        cv2.imwrite(reference_path, reference)
        cv2.imwrite(actual_path, crop)
        cv2.imwrite(diff_path, diff)

        expected_content = base64.b64encode(Path(reference_path).read_bytes()).decode()
        actual_content = base64.b64encode(Path(actual_path).read_bytes()).decode()
        diff_content = base64.b64encode(Path(diff_path).read_bytes()).decode()

        content = json.dumps({
            'expected': f'data:image/png;base64,{expected_content}',
            'actual': f'data:image/png;base64,{actual_content}',
            'diff': f'data:image/png;base64,{diff_content}'
        }).encode()

        allure.attach(content, name='Screenshot Diff', attachment_type='application/vnd.allure.image.diff')
    except Exception as e:
        print(f"Failed to attach snapshot diff: {e}")
