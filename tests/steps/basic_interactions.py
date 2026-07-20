from behave import given, when
from dogtail import rawinput

import infrastructure.interactions


@when('I click on element containing "{label}"')
def step_impl(context, label):
    infrastructure.interactions.click_on_text(label, partial=True)


@when('I click on "{label}"')
def step_impl(context, label):
    infrastructure.interactions.click_on_text(label)


@when('I press "{key}"')
def step_impl(context, key):
    parts = key.split('+')
    # Map common key names to dogtail/X11 keysym names
    mapped = []
    for part in parts:
        match part.strip():
            case 'Ctrl':
                mapped.append('<Control>')
            case 'Alt':
                mapped.append('<Alt>')
            case 'Shift':
                mapped.append('<Shift>')
            case 'Enter':
                mapped.append('Return')
            case other:
                mapped.append(other)

    if len(mapped) == 1:
        rawinput.pressKey(mapped[0])
    else:
        combo = ''.join(mapped)
        rawinput.keyCombo(combo)


@when('I enter "{text}" into "{field_name}"')
def step_impl(context, text, field_name):
    infrastructure.interactions.enter_text_into_field(text, field_name)


@when('I enter "{text}"')
def step_impl(context, text):
    rawinput.typeText(text)


@given('I listen for sACN on universe {universe:d}')
def step_impl(context, universe):
    context.sacn_receiver.listen(universe)
