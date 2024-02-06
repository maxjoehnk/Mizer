from behave import given

from infrastructure.interactions import click_on_text


@given('I start a new project')
def step_impl(context):
    click_on_text('File')
    click_on_text('New')
