@manual_start
Feature: Sequencer

  Background:
    Given I listen for sACN on universe 1
    And I load the project "sequencer_test.yml"
    When I open the Sequencer view

  Scenario: Go forward triggers first cue and outputs DMX
    When I click on element containing "Basic Sequence"
    And I click on "Go+"
    Then DMX channel 1 on universe 1 should have value 255

  Scenario: Go forward advances to next cue
    When I click on element containing "Basic Sequence"
    And I click on "Go+"
    And I click on "Go+"
    Then DMX channel 1 on universe 1 should have value 0

  Scenario: Go backward returns to previous cue
    When I click on element containing "Basic Sequence"
    And I click on "Go+"
    And I click on "Go+"
    And I click on "Go-"
    Then DMX channel 1 on universe 1 should have value 255

  Scenario: Follow trigger auto-advances to next cue
    When I click on element containing "Follow Sequence"
    And I click on "Go+"
    Then DMX channel 1 on universe 1 should have value 255
    When I wait for 3 seconds
    Then DMX channel 1 on universe 1 should have value 0

  Scenario: Wrap-around loops back to first cue
    When I click on element containing "Wrap Sequence"
    And I click on "Go+"
    And I click on "Go+"
    And I click on "Go+"
    Then DMX channel 1 on universe 1 should have value 255
