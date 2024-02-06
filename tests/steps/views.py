from behave import when, register_type

from infrastructure.views import *


@when('I open the {view} view')
def step_impl(context, view: str):
    view = parse_view(view)
    open_view(view)


def parse_view(text: str) -> View:
    match text:
        case "Layout":
            return View.LAYOUT
        case "Plan":
            return View.PLAN
        case "Nodes":
            return View.NODES
        case "Sequencer":
            return View.SEQUENCER
        case "Fixtures":
            return View.FIXTURES
        case "Presets":
            return View.PRESETS
        case "Effects":
            return View.EFFECTS
        case "Media":
            return View.MEDIA
        case "Surfaces":
            return View.SURFACES
        case "Connections":
            return View.CONNECTIONS
        case "Patch":
            return View.PATCH
        case "Timecode":
            return View.TIMECODE
        case "Session":
            return View.SESSION
        case "History":
            return View.HISTORY
        case "Preferences":
            return View.PREFERENCES


register_type(View=parse_view)
