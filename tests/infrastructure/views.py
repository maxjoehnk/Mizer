from enum import Enum

from dogtail import rawinput

from infrastructure.interactions import click_on_text


class View(Enum):
    LAYOUT = 1
    PLAN = 2
    NODES = 3
    SEQUENCER = 4
    FIXTURES = 5
    PRESETS = 6
    EFFECTS = 7
    MEDIA = 8
    SURFACES = 9
    CONNECTIONS = 10
    PATCH = 11
    TIMECODE = 12
    SESSION = 13
    HISTORY = 14
    PREFERENCES = 15


def open_view(view: View):
    match view:
        case View.LAYOUT:
            rawinput.pressKey('F1')
        case View.PLAN:
            rawinput.pressKey('F2')
        case View.NODES:
            rawinput.pressKey('F3')
        case View.SEQUENCER:
            rawinput.pressKey('F4')
        case View.FIXTURES:
            rawinput.pressKey('F5')
        case View.PRESETS:
            rawinput.pressKey('F6')
        case View.EFFECTS:
            rawinput.pressKey('F7')
        case View.MEDIA:
            rawinput.pressKey('F8')
        case View.SURFACES:
            rawinput.pressKey('F9')
        case View.PATCH:
            click_on_text('Patch')
        case View.CONNECTIONS:
            rawinput.pressKey('F12')
        case View.TIMECODE:
            click_on_text('Timecode')
        case View.SESSION:
            click_on_text('Session')
        case View.HISTORY:
            click_on_text('History')
