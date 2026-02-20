Feature: Fixture Output

  Scenario: Highlighting a fixture sends output via dmx
    Given I start a new project
    And I listen for sACN on universe 1
    And I patch the fixture "Root Par 6" with mode "8 Channel"
    When I open the Fixtures view
    And I click on element containing "Root PAR 6 1"
    And I open the programmer
    And I click on "Highlight"
    Then DMX channel 1 on universe 1 should have value 255
    Then DMX channel 2 on universe 1 should have value 0
    Then DMX channel 6 on universe 1 should have value 255
