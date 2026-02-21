import base64
import json
import os
import subprocess
from pathlib import Path

import dogtail.tree
import pyautogui
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


def assert_snapshot(snapshot_name: str):
    """Assert that the reference snapshot is visible on screen.

    Takes a screenshot for debugging, then checks if the reference
    snapshot from snapshots/ can be found on screen.
    On failure, attaches expected/actual/diff images to the Allure report.
    """
    import allure
    import cv2
    import numpy as np

    result_path = f'results/screenshots/{snapshot_name}.png'
    reference_path = f'snapshots/{snapshot_name}.png'

    if not os.path.exists(reference_path):
        raise FileNotFoundError(
            f'Reference snapshot not found: {reference_path}. '
            f'Screenshot saved to {result_path}. '
            f'To create the baseline, copy the result: cp {result_path} {reference_path}'
        )

    os.makedirs(os.path.dirname(result_path), exist_ok=True)
    try:
        location = pyautogui.locateOnScreen(reference_path, minSearchTime=2, confidence=0.9)
    except pyautogui.ImageNotFoundException:
        location = None
    try:
        take_screenshot(result_path)
    except subprocess.CalledProcessError:
        pass

    if location is None:
        _attach_snapshot_diff(reference_path, result_path, snapshot_name)

    assert location is not None, (
        f'Snapshot "{snapshot_name}" not found on screen. '
        f'Screenshot saved to {result_path} for comparison with {reference_path}'
    )


def _attach_snapshot_diff(reference_path: str, screenshot_path: str, name: str):
    """Attach expected, actual (best-match crop), and diff images to Allure."""
    import allure
    import cv2
    import numpy as np

    try:
        ref = cv2.imread(reference_path)
        screenshot = cv2.imread(screenshot_path)
        if ref is None or screenshot is None:
            return

        h, w = ref.shape[:2]
        result = cv2.matchTemplate(screenshot, ref, cv2.TM_CCOEFF_NORMED)
        _, _, _, max_loc = cv2.minMaxLoc(result)
        x, y = max_loc
        crop = screenshot[y:y + h, x:x + w]

        diff = cv2.absdiff(ref, crop)

        diff_dir = 'results/screenshots/diffs'
        os.makedirs(diff_dir, exist_ok=True)
        actual_path = f'{diff_dir}/{name}_actual.png'
        diff_path = f'{diff_dir}/{name}_diff.png'

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
