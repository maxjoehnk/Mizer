from time import sleep

from behave import then, use_step_matcher, given


@given('I listen for OSC on port {port:d}')
def step_impl(context, port):
    context.osc_receiver.start(port)


use_step_matcher("re")


def _poll_osc_value(context, address, predicate, retries=10, interval=0.5):
    """Poll the OSC receiver until predicate(value) is True or retries are exhausted.

    Returns the last value seen (may be None).
    """
    osc_receiver = context.osc_receiver
    actual = None
    for _ in range(retries):
        actual = osc_receiver.get_value(address)
        if actual is not None and predicate(actual):
            return actual
        sleep(interval)
    return actual


@then('OSC address "(?P<address>[^"]+)" should have int value (?P<value>-?\\d+)')
def step_impl(context, address, value):
    expected = int(value)
    actual = _poll_osc_value(context, address, lambda v: isinstance(v, int) and v == expected)

    assert actual is not None, (
        f'Expected OSC address "{address}" to have int value {expected}, but no message was received'
    )
    assert isinstance(actual, int), (
        f'Expected OSC address "{address}" to have int value, but got {type(actual).__name__}: {actual}'
    )
    assert actual == expected, (
        f'Expected OSC address "{address}" to have int value {expected}, but got {actual}'
    )


@then('OSC address "(?P<address>[^"]+)" should have float value (?P<value>-?[\\d.]+)')
def step_impl(context, address, value):
    expected = float(value)
    actual = _poll_osc_value(context, address, lambda v: isinstance(v, float) and abs(v - expected) < 1e-6)

    assert actual is not None, (
        f'Expected OSC address "{address}" to have float value {expected}, but no message was received'
    )
    assert isinstance(actual, float), (
        f'Expected OSC address "{address}" to have float value, but got {type(actual).__name__}: {actual}'
    )
    assert abs(actual - expected) < 1e-6, (
        f'Expected OSC address "{address}" to have float value {expected}, but got {actual}'
    )


@then('OSC address "(?P<address>[^"]+)" should have double value (?P<value>-?[\\d.]+)')
def step_impl(context, address, value):
    expected = float(value)
    actual = _poll_osc_value(context, address, lambda v: isinstance(v, float) and abs(v - expected) < 1e-9)

    assert actual is not None, (
        f'Expected OSC address "{address}" to have double value {expected}, but no message was received'
    )
    assert isinstance(actual, float), (
        f'Expected OSC address "{address}" to have double value, but got {type(actual).__name__}: {actual}'
    )
    assert abs(actual - expected) < 1e-9, (
        f'Expected OSC address "{address}" to have double value {expected}, but got {actual}'
    )


@then('OSC address "(?P<address>[^"]+)" should have bool value (?P<value>true|false)')
def step_impl(context, address, value):
    expected = value.lower() == 'true'
    actual = _poll_osc_value(context, address, lambda v: isinstance(v, bool) and v == expected)

    assert actual is not None, (
        f'Expected OSC address "{address}" to have bool value {expected}, but no message was received'
    )
    assert isinstance(actual, bool), (
        f'Expected OSC address "{address}" to have bool value, but got {type(actual).__name__}: {actual}'
    )
    assert actual == expected, (
        f'Expected OSC address "{address}" to have bool value {expected}, but got {actual}'
    )


@then('OSC address "(?P<address>[^"]+)" should have string value "(?P<value>[^"]*)"')
def step_impl(context, address, value):
    actual = _poll_osc_value(context, address, lambda v: isinstance(v, str) and v == value)

    assert actual is not None, (
        f'Expected OSC address "{address}" to have string value "{value}", but no message was received'
    )
    assert isinstance(actual, str), (
        f'Expected OSC address "{address}" to have string value, but got {type(actual).__name__}: {actual}'
    )
    assert actual == value, (
        f'Expected OSC address "{address}" to have string value "{value}", but got "{actual}"'
    )


def _unpack_rgba(value: int) -> tuple[int, int, int, int]:
    """Unpack a 32-bit RGBA integer into (r, g, b, a) components.

    pythonosc returns OSC color values as a single packed uint32."""
    return ((value >> 24) & 0xFF, (value >> 16) & 0xFF, (value >> 8) & 0xFF, value & 0xFF)


@then('OSC address "(?P<address>[^"]+)" should have color value \\((?P<r>\\d+),\\s*(?P<g>\\d+),\\s*(?P<b>\\d+),\\s*(?P<a>\\d+)\\)')
def step_impl(context, address, r, g, b, a):
    expected = (int(r), int(g), int(b), int(a))

    def matches(v):
        if not isinstance(v, int):
            return False
        return _unpack_rgba(v) == expected

    actual = _poll_osc_value(context, address, matches)

    assert actual is not None, (
        f'Expected OSC address "{address}" to have color value {expected}, but no message was received'
    )
    assert isinstance(actual, int), (
        f'Expected OSC address "{address}" to have color value (r, g, b, a), but got {type(actual).__name__}: {actual}'
    )
    actual_rgba = _unpack_rgba(actual)
    assert actual_rgba == expected, (
        f'Expected OSC address "{address}" to have color value {expected}, but got {actual_rgba}'
    )


@then('OSC address "(?P<address>[^"]+)" should have value (?P<value>[\\d.]+)')
def step_impl(context, address, value):
    expected = float(value)
    actual = _poll_osc_value(context, address, lambda v: float(v) == expected)

    assert actual is not None and float(actual) == expected, (
        f'Expected OSC address "{address}" to have value {expected}, '
        f'but got {actual}'
    )


@then('OSC address "(?P<address>[^"]+)" should have received a message')
def step_impl(context, address):
    osc_receiver = context.osc_receiver

    message = None
    for _ in range(10):
        message = osc_receiver.get_message(address)
        if message is not None:
            break
        sleep(0.5)

    assert message is not None, (
        f'Expected to receive an OSC message at "{address}", but none was received'
    )


use_step_matcher("parse")
