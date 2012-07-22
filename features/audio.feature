@focus
Feature:  Support for the audio element

  Background:
    Given I am on the static elements page

  Scenario: finding an audio element
    When I retrieve the audio element
    Then I should know it exists
    And I should know it is visible

  Scenario Outline: Locating an audio element on the page
    When I search for the audio element by "<search_by>"
    Then I should know it is visible

  Examples:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |

  Scenario Outline: Locating audios using multiple parameters
    When I search for the audio element by "<param1>" and "<param2>"
    Then I should know it is visible

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

