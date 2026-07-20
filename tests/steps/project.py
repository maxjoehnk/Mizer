from behave import given

from infrastructure.interactions import click_on_text

@given('I load the project "{project_name}"')
def step_impl(context, project_name):
    context.mizer.start(f'projects/{project_name}')

@given('I start a new project')
def step_impl(context):
    click_on_text('Project')
    click_on_text('New')

@given('I patch the fixture "{fixture}" with mode "{mode}"')
def step_impl(context, fixture, mode):
    context.execute_steps(f'''
        When I open the Patch view
        And I click on "Add Fixture"
        And I enter "{fixture}"
        And I click on "{mode}"
        And I click on "Next"
        And I click on "Add Fixtures"
    ''')
