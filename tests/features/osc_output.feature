@manual_start
Feature: OSC Output

  Background:
    Given I listen for OSC on port 8000
    And I load the project "osc_output.yml"

  Scenario: OSC Output Node sends float data
    Then OSC address "/test/float" should have float value 0.5

  Scenario: OSC Output Node sends integer data
    Then OSC address "/test/int" should have int value 0

  Scenario: OSC Output Node sends double data
    Then OSC address "/test/double" should have double value 0.25

  Scenario: OSC Output Node sends boolean data
    Then OSC address "/test/bool" should have bool value false

  Scenario: OSC Output Node sends string data
    Then OSC address "/test/string" should have string value "Hello OSC"

  Scenario: OSC Output Node sends color data
    Then OSC address "/test/color" should have color value (255,127,0,255)

