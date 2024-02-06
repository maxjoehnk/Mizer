from time import sleep

import pyautogui

import infrastructure.interactions
from infrastructure.launcher import Mizer
from infrastructure.views import *

with Mizer() as mizer:
    mizer.start('examples/demo.yml')
    # wait for application to open
    sleep(1)

    pyautogui.hotkey('win', 'f')

    open_view(View.LAYOUT)
    infrastructure.interactions.take_screenshot('../docs/screenshots/layout.png')

    open_view(View.PLAN)
    infrastructure.interactions.take_screenshot('../docs/screenshots/plan.png')

    open_view(View.NODES)
    infrastructure.interactions.move_to_center()
    pyautogui.dragRel(550, 0, button='middle')
    pyautogui.moveRel(-950, -200)
    pyautogui.click()
    infrastructure.interactions.move_to_center()
    pyautogui.scroll(-5)
    pyautogui.dragRel(0, -100, button='middle')
    infrastructure.interactions.take_screenshot('../docs/screenshots/nodes.png')

    open_view(View.FIXTURES)
    infrastructure.interactions.click_on_text('2')
    infrastructure.interactions.click_on_text('3')
    infrastructure.interactions.click_on_text('4')
    infrastructure.interactions.click_on_text('7')
    infrastructure.interactions.click_on_text('8')
    infrastructure.interactions.click_on_text('9')
    infrastructure.interactions.take_screenshot('../docs/screenshots/programmer.png')

    open_view(View.PRESETS)
    infrastructure.interactions.take_screenshot('../docs/screenshots/presets.png')

    open_view(View.CONNECTIONS)
    infrastructure.interactions.take_screenshot('../docs/screenshots/connections.png')

    open_view(View.PATCH)
    infrastructure.interactions.take_screenshot('../docs/screenshots/patch.png')

    open_view(View.SEQUENCER)
    infrastructure.interactions.take_screenshot('../docs/screenshots/sequencer.png')

    infrastructure.interactions.click_on_text('Strobe')
    infrastructure.interactions.take_screenshot('../docs/screenshots/sequencer_cue_list.png')

    infrastructure.interactions.click_on_text('Sequence Settings')
    infrastructure.interactions.take_screenshot('../docs/screenshots/sequencer_settings.png')

    infrastructure.interactions.click_on_text('Track Sheet')
    infrastructure.interactions.take_screenshot('../docs/screenshots/sequencer_track_sheet.png')
