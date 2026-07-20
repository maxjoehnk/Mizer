from time import sleep

from behave import then, use_step_matcher

from infrastructure.interactions import assert_snapshot, element_exists


@then('I expect to see the snapshot "{snapshot_name}"')
def step_impl(context, snapshot_name):
    assert_snapshot(snapshot_name)


@then('I should see "{text}"')
def step_impl(context, text):
    assert element_exists(text), f'Expected to find element "{text}" in the accessibility tree'


@then('I should not see "{text}"')
def step_impl(context, text):
    assert not element_exists(text), f'Expected not to find element "{text}" in the accessibility tree'


use_step_matcher("re")


@then('DMX channel (?P<channel>\\d+) on universe (?P<universe>\\d+) should have value (?P<value>\\d+)')
def step_impl(context, channel, universe, value):
    channel = int(channel)
    universe = int(universe)
    expected = int(value)
    sacn_receiver = context.sacn_receiver

    actual = None
    for _ in range(10):
        actual = sacn_receiver.get_channel_value(universe, channel)
        if actual == expected:
            break
        sleep(0.5)

    assert actual == expected, (
        f'Expected DMX channel {channel} on universe {universe} to be {expected}, '
        f'but got {actual}'
    )


use_step_matcher("parse")
