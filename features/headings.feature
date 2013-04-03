Feature: Headings

  Background:
    Given I am on the static elements page

  Scenario: Getting the text of headings
    When I get the text for the "h1" element
    Then I should see "h1's are cool"
    When I get the text for the "h2" element
    Then I should see "h2's are cool"
    When I get the text for the "h3" element
    Then I should see "h3's are cool"
    When I get the text for the "h4" element
    Then I should see "h4's are cool"
    When I get the text for the "h5" element
    Then I should see "h5's are cool"
    When I get the text for the "h6" element
    Then I should see "h6's are cool"

  Scenario Outline: Locating h1s on the Page
    When I search for the heading1 by "<search_by>"
    Then I should see "h1's are cool"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario Outline: Locating h2s on the Page
    When I search for the heading2 by "<search_by>"
    Then I should see "h2's are cool"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario Outline: Locating h3s on the Page
    When I search for the heading3 by "<search_by>"
    Then I should see "h3's are cool"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario Outline: Locating h4s on the Page
    When I search for the heading4 by "<search_by>"
    Then I should see "h4's are cool"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario Outline: Locating h5s on the Page
    When I search for the heading5 by "<search_by>"
    Then I should see "h5's are cool"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

  Scenario Outline: Locating h6s on the Page
    When I search for the heading6 by "<search_by>"
    Then I should see "h6's are cool"

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | name      |
    | xpath     |
    | index     |
    | css       |

