import pyautogui
from behave import then


@then('I expect to see the snapshot "{snapshot_name}"')
def step_impl(context, snapshot_name):
    img_path = f"snapshots/{snapshot_name}.png"
    print(f"Looking for {img_path}")
    coordinates = pyautogui.locateOnScreen(img_path, minSearchTime=2, confidence=0.9)

    assert coordinates is not None, f"Expected to find snapshot {snapshot_name} on the screen"
