from pathlib import Path

import allure
from behave.model import Scenario

import subprocess

from infrastructure.interactions import take_screenshot
from infrastructure.launcher import Mizer
from infrastructure.osc import OscReceiver
from infrastructure.sacn import SacnReceiver

def before_all(context):
    Path('results/screenshots').mkdir(parents=True, exist_ok=True)
    context.mizer = Mizer()
    context.mizer.extract()


def after_all(context):
    context.mizer.cleanup()


def before_scenario(context, scenario: Scenario):
    context.sacn_receiver = SacnReceiver()
    context.sacn_receiver.start()
    context.osc_receiver = OscReceiver()
    if 'manual_start' not in scenario.effective_tags:
        context.mizer.start(None)


def after_scenario(context, scenario):
    print(f"after_scenario: {scenario.name} - {scenario.status}")
    screenshot_path = f'results/screenshots/{scenario.name}.png'
    try:
        try:
            take_screenshot(screenshot_path)
        except Exception:
            # Focused-window capture fails when the window is gone (e.g. crash).
            # Fall back to a full-screen capture.
            subprocess.run(['scrot', '-o', screenshot_path], check=True)
        allure.attach.file(
            screenshot_path,
            name='screenshot',
            attachment_type=allure.attachment_type.PNG,
        )
    except Exception as e:
        print(f"Failed to take screenshot: {e}")
    try:
        log_path = context.mizer.log_path
        if Path(log_path).exists():
            log_content = Path(log_path).read_text()
            allure.attach(
                log_content,
                name='mizer.log',
                attachment_type=allure.attachment_type.TEXT,
            )
    except Exception as e:
        print(f"Failed to attach mizer log: {e}")
    try:
        osc_log = context.osc_receiver.get_log()
        if osc_log:
            allure.attach(
                osc_log,
                name='osc_messages.log',
                attachment_type=allure.attachment_type.TEXT,
            )
    except Exception as e:
        print(f"Failed to attach OSC log: {e}")
    context.mizer.stop()
    context.sacn_receiver.stop()
    context.osc_receiver.stop()
