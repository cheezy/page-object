Feature: Handling frames

  Scenario: Accessing elements within the frame
    Given I am on the frame elements page
    When I type "page-object" into the text field for frame 2 using "id"
    Then I should verify "page-object" is in the text field for frame 2 using "id"
    When I type "page-object" into the text field for frame 2 using "name"
    Then I should verify "page-object" is in the text field for frame 2 using "name"
    When I type "page-object" into the text field for frame 2 using "index"
    Then I should verify "page-object" is in the text field for frame 2 using "index"

  Scenario: Accessing elements within the frame using Regexp
    Given I am on the frame elements page
    When I type "page-object" into the text field for frame 2 using "regex"
    Then I should verify "page-object" is in the text field for frame 2 using "regex"

  Scenario: Accessing elements within the frame using multiple identifiers
    Given I am on the iframe elements page
    When I type "page-object" into the text field for frame 2 using "multiple identifiers"
    Then I should verify "page-object" is in the text field for frame 2 using "multiple identifiers"

  Scenario: Switching between frames
    Given I am on the frame elements page
    When I type "page-object" into the text field for frame 2 using "id"
    And I type "page-object" into the text field from frame 1 using "id"
    Then I should verify "page-object" is in the text field for frame 2 using "id"
    And I should verify "page-object" is in the text field for frame 1 using "id"

  Scenario: Accessing elements within the frame
    Given I am on the iframe elements page
    When I type "page-object" into the text field for frame 2 using "id"
    Then I should verify "page-object" is in the text field for frame 2 using "id"
    When I type "page-object" into the text field for frame 2 using "name"
    Then I should verify "page-object" is in the text field for frame 2 using "name"
    When I type "page-object" into the text field for frame 2 using "index"
    Then I should verify "page-object" is in the text field for frame 2 using "index"

  Scenario: Switching between frames
    Given I am on the iframe elements page
    When I type "page-object" into the text field for frame 2 using "id"
    And I type "page-object" into the text field from frame 1 using "id"
    Then I should verify "page-object" is in the text field for frame 2 using "id"
    And I should verify "page-object" is in the text field for frame 1 using "id"
    
  Scenario: Nested frames
    Given I am on the nested frame elements page
    Then I should be able to click the link in the frame

  Scenario: Identifying items in frames at runtime
    Given I am on the frame elements page
    When I type "page-object" into the text field from frame 1 identified dynamically
    Then I should verify "page-object" in the text field for frame 1 identified dynamically

  Scenario: Identifying items in iframes at runtime
    Given I am on the iframe elements page
    When I type "page-object" into the text field from iframe 1 identified dynamically
    Then I should verify "page-object" in the text field for iframe 1 identified dynamically

  Scenario: Interacting with elements in an iframe
    Given I am on the iframe elements page
    When I retrieve a text field element within an iframe
    Then I should be able to get the name of the text field element within an iframe

  Scenario: Handling alerts inside frames
    Given I am on the frame elements page
    When I trigger an alert within a frame
    Then I should be able to get the alert's message

  Scenario: Handling confirms inside frames
    Given I am on the frame elements page
    When I trigger a confirm within a frame
    Then I should be able to get the confirm message

  Scenario: Handling prompts inside frames
    Given I am on the frame elements page
    When I trigger a prompt within a frame
    Then I should be able to get the message and default value
