Feature: Handling frames

  Scenario: Accessing elements within the frame
    Given I am on the frame elements page
    When I type "page-object" into the text field for frame 2 using "id"
    Then I should verify "page-object" is in the text field for frame 2 using "id"
    When I type "page-object" into the text field for frame 2 using "name"
    Then I should verify "page-object" is in the text field for frame 2 using "name"
    When I type "page-object" into the text field for frame 2 using "index"
    Then I should verify "page-object" is in the text field for frame 2 using "index"
    #And I should be able to get the text fields text from frame 2 using "index"

@watir_only    
  Scenario: Accessing elements withing the frame using Regexp
    Given I am on the frame elements page
    When I type "page-object" into the text field for frame 2 using "regex"
    Then I should verify "page-object" is in the text field for frame 2 using "regex"

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
