Feature: Image

  Background:
    Given I am on the static elements page

  Scenario: Getting the image element
    When I get the image element
    Then the image should be "106" pixels wide
    And the image should be "106" pixels tall

  Scenario Outline: Locating an image on the page
    When I get the image element by "<search_by>"
    Then the image should be "106" pixels wide
    And the image should be "106" pixels tall

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | alt       |
    | src       |

  @selenium_only
  Scenario Outline: Locating an image on the page
    When I get the image element by "<search_by>"
    Then the image should be "106" pixels wide
    And the image should be "106" pixels tall

  Scenarios:
    | search_by |
    | css       |

  Scenario Outline: Locating an image using multiple parameters
    When I get the image element by "<param1>" and "<param2>"
    Then the image should be "106" pixels wide
    And the image should be "106" pixels tall

  Scenarios:
    | param1 | param2 |
    | class  | index  |
    | name   | index  |

  Scenario: Finding an image dynamically
    When I get the image element while the script is executing
    Then I should see that the image exists
    And the image should be "106" pixels wide
    And the image should be "106" pixels tall
