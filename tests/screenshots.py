from time import sleep

from dogtail import rawinput

import infrastructure.interactions
from infrastructure.launcher import Mizer
from infrastructure.views import *

with Mizer() as mizer:
    mizer.start('../examples/demo.yml')
    sleep(5)

    rawinput.keyCombo('<Super_L>f')

    open_view(View.LAYOUT)
    infrastructure.interactions.take_screenshot('../docs/screenshots/layout.png')

    open_view(View.PLAN)
    infrastructure.interactions.take_screenshot('../docs/modules/fixtures/images/plan.png')

    open_view(View.NODES)
    cx, cy = infrastructure.interactions.get_window_center()
    rawinput.drag((cx, cy), (cx + 550, cy), button=2)
    rawinput.absoluteMotion(cx - 400, cy - 200)
    rawinput.click(cx - 400, cy - 200)
    cx, cy = infrastructure.interactions.get_window_center()
    infrastructure.interactions.scroll_at(cx, cy, -5)
    rawinput.drag((cx, cy), (cx, cy - 100), button=2)
    infrastructure.interactions.take_screenshot('../docs/screenshots/nodes.png')

    open_view(View.FIXTURES)
    infrastructure.interactions.click_on_text('Wild Wash 2', partial=True)
    infrastructure.interactions.click_on_text('Wild Wash 3', partial=True)
    infrastructure.interactions.click_on_text('Wild Wash 4', partial=True)
    infrastructure.interactions.click_on_text('Wild Wash 7', partial=True)
    infrastructure.interactions.click_on_text('Wild Wash 8', partial=True)
    infrastructure.interactions.click_on_text('Wild Wash 9', partial=True)
    infrastructure.interactions.take_screenshot('../docs/modules/fixtures/images/programmer.png')

    open_view(View.PRESETS)
    infrastructure.interactions.take_screenshot('../docs/modules/fixtures/images/presets.png')

    open_view(View.CONNECTIONS)
    infrastructure.interactions.take_screenshot('../docs/screenshots/connections.png')

    open_view(View.PATCH)
    infrastructure.interactions.take_screenshot('../docs/modules/fixtures/images/patch.png')

    open_view(View.SEQUENCER)
    infrastructure.interactions.take_screenshot('../docs/modules/sequencer/images/sequencer.png')

    infrastructure.interactions.click_on_text('Strobe', partial=True)
    infrastructure.interactions.take_screenshot('../docs/modules/sequencer/images/sequencer_cue_list.png')

    infrastructure.interactions.click_on_text('Sequence Settings')
    infrastructure.interactions.take_screenshot('../docs/modules/sequencer/images/sequencer_settings.png')

    infrastructure.interactions.click_on_text('Track Sheet')
    infrastructure.interactions.take_screenshot('../docs/modules/sequencer/images/sequencer_track_sheet.png')
