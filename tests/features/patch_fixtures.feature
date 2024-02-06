Feature: Fixture Patch
  Background:
    Given I start a new project

  Scenario: Patch new fixtures
    When I open the Patch view
    And I wait for 1 seconds
    And I click on "Add Fixture"
    And I wait for 1 seconds
    And I enter "Root Par 6"
    And I click on "8 Channel"
    And I click on "Next"
    And I click on "Count"
    And I press "Ctrl+a"
    And I enter "10"
#    And I click on "Add Fixtures"
    And I press "Enter"
    Then I expect to see the snapshot "new_fixture_patch"

