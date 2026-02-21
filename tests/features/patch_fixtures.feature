Feature: Fixture Patch
  Background:
    Given I start a new project

  Scenario: Patch new fixtures
    When I open the Patch view
    And I click on "Add Fixture"
    And I enter "Root Par 6"
    And I click on "8 Channel"
    And I click on "Next"
    And I enter "10" into "Count"
    And I click on "Add Fixtures"
    Then I expect to see the snapshot "new_fixture_patch"

