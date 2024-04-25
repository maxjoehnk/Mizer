from enum import Enum

import pyautogui

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
            pyautogui.hotkey('F1')
        case View.PLAN:
            pyautogui.hotkey('F2')
        case View.NODES:
            pyautogui.hotkey('F3')
        case View.SEQUENCER:
            pyautogui.hotkey('F4')
        case View.FIXTURES:
            pyautogui.hotkey('F5')
        case View.PRESETS:
            pyautogui.hotkey('F6')
        case View.EFFECTS:
            pyautogui.hotkey('F7')
        case View.MEDIA:
            pyautogui.hotkey('F8')
        case View.SURFACES:
            pyautogui.hotkey('F9')
        case View.PATCH:
            pyautogui.hotkey('F10')
        case View.CONNECTIONS:
            pyautogui.hotkey('F12')
        case View.TIMECODE:
            click_on_text('Timecode')
        case View.SESSION:
            click_on_text('Session')
        case View.HISTORY:
            click_on_text('History')
