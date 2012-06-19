Feature: Indexed Property
  In order to interact with recurring sequences of elements with an index
  Testers will need access and interrogation ability

  Background:
    Given I am on the indexed property page

  Scenario Outline: Locating indexed text fields in a table on the Page by id
    When I search for the elements for index "<index>"
    And I type "I found it" into the table's indexed text field by id
    Then The table's indexed text field by id should contain "I found it"

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |

  Scenario Outline: Locating indexed text fields in a table on the Page by name
    When I search for the elements for index "<index>"
    And I type "I found it" into the table's indexed text field by name
    Then The table's indexed text field by name should contain "I found it"

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |

  Scenario Outline: Locating indexed radio buttons in a table on the Page
    When I search for the elements for index "<index>"
    And I select the indexed radio button
    Then The indexed radio button should be selected

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |

  Scenario Outline: Locating indexed checkboxes in a table on the Page
    When I search for the elements for index "<index>"
    And I check the indexed checkbox
    Then The indexed checkbox should be checked

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |

  Scenario Outline: Locating indexed text areas in a table on the Page
    When I search for the elements for index "<index>"
    And I type "I found it" into the table's indexed text area
    Then The table's indexed text area should contain "I found it"

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |

  Scenario Outline: Locating indexed buttons in a table on the Page
    When I search for the elements for index "<index>"
    Then I should see that the indexed button exists
    And I should be able to click the indexed button

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |

  Scenario Outline: Locating indexed text fields outside a table on the Page
    When I search for the elements for index "<index>"
    And I type "I found it" into the regular indexed text field by id
    Then The regular indexed text field by id should contain "I found it"

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |
