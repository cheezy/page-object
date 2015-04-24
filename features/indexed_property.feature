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

  Scenario Outline: Locating indexed text fields by index in a table on the page
    When I search for the elements for index "<index>"
    And I select the table's indexed radio button
    Then The table's indexed radio button should be selected

  Scenarios:
    | index |
    | 0     |
    | 1     |

  Scenario Outline: Locating indexed text fields outside a table on the Page
    When I search for the elements for index "<index>"
    And I type "I found it" into the regular indexed text field by id
    Then The regular indexed text field by id should contain "I found it"

  Examples:
    | index  |
    | foo    |
    | 123    |
    | 12test |

  Scenario: Element on first indexed property but not second
    When I search for an element that is on an indexed property
    And I search for the element on another indexed property it is not on
    Then I should see that the element doesn't exist

  Scenario: Index on first indexed property but not on second
    When I search for an element by an index on an indexed property
    And I search using the index which is not on another indexed property
    Then I should see that the element doesn't exist for that index

  Scenario: Index on first indexed property and different on second
    When I search for an element with text by an index on an indexed property
    And I search using an index which is on another indexed property
    Then I should see the content of the element on the second indexed property

  Scenario: Different indexes on stored indexed property
    When I search for an element with text by an index on an indexed property
    And I search for a different element with text by index on the indexed property
    Then I should see the contents of both elements

  Scenario: Can't redefine ruby methods
    When I use a name that collides with a ruby method on an indexed property
    Then the original method remains