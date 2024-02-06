import time

from behave import step
from behave.runner import Context


@step('I wait for {seconds:d} seconds')
def step_impl(context: Context, seconds: int):
    time.sleep(seconds)
