import pyautogui
from behave import when

import infrastructure.interactions


@when('I click on "{label}"')
def step_impl(context, label):
    infrastructure.interactions.click_on_text(label)


@when('I press "{key}"')
def step_impl(context, key):
    keys = key.split('+')
    pyautogui.hotkey(keys)


@when('I enter "{text}"')
def step_impl(context, text):
    pyautogui.write(text)
