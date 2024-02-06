from pathlib import Path
from time import sleep

from infrastructure.interactions import take_screenshot
from infrastructure.launcher import Mizer


def before_all(context):
    Path('results/screenshots').mkdir(parents=True, exist_ok=True)
    context.mizer = Mizer()
    context.mizer.extract()


def after_all(context):
    context.mizer.cleanup()


def before_scenario(context, scenario):
    context.mizer.start(None)
    sleep(1)


def after_scenario(context, scenario):
    if scenario.status == 'failed':
        take_screenshot(f'results/screenshots/{scenario.name}.png')
    context.mizer.stop()
