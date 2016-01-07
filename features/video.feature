Feature: Support for video element

  Background:
    Given I am on the audio video page

  Scenario: finding an video element
    When I retrieve the video element
    Then I should know it exists
    And I should know it is visible
    
  Scenario Outline: Locating a video element on the page
    When I search for the video element by "<search_by>"
    Then I should know it is visible

  Examples:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario Outline: Locating videos using multiple parameters
    When I search for the video element by "<param1>" and "<param2>"
    Then I should know it is visible

  Examples:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Should know if it is autoplay
    When I retrieve the video element
    Then I should know the video is not autoplay
    
  Scenario: Should know if the controls are displayed
    When I retrieve the video element
    Then I should know that the controls are displayed

  Scenario: Should know if it is paused
    When I retrieve the video element
    Then I should know that the video is paused

  Scenario: Should know its volume
    When I retrieve the video element
    Then I should know that its volume is 1

  Scenario: Should know its height and width
    When I retrieve the video element
    Then I should know that its height is 240 pixels
    And I should knot what its width is 320 pixels
    
  Scenario: Should know if it has ended
    When I retrieve the video element
    Then I should know that it has not ended

  Scenario: Should know if it is seeking
    When I retrieve the video element
    Then I should know that it is not seeking

  Scenario: Should know if it is in a loop
    When I retrieve the video element
    Then I should know that it is not in a loop

  Scenario: Should know if it is muted
    When I retrieve the video element
    Then I should know that it is muted

