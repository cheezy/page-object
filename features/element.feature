Feature: Elements

  Background:
    Given I am on the static elements page

  Scenario: Link element methods
    When I retrieve a link element
    Then I should know it exists
    And I should know it is visible
    And I should know its' text is "Google Search"
    And I should know it is equal to itself
    And I should know its' tag name is "a"
    And I should know the attribute "readonly" is false
    
  @watir_only
  Scenario: Link element methods for watir
    When I retrieve a link element
    And I should know its' value is ""
    

  Scenario: Button element methods
    When I retrieve a button element
    Then I should know it exists
    And I should know it is visible
    And I should know its' value is "Click Me"
    And I should know it is equal to itself
    And I should know its' tag name is "input"
    And I should know the attribute "readonly" is false
    
  @watir_only
  Scenario: Button element methods for watir
    When I retrieve a button element
    And I should know its' text is "Click Me"

  Scenario: Check Box element methods
    When I retrieve a check box element
    Then I should know it exists
    And I should know it is visible
    And I should know its' text is ""
    And I should know its' value is "1"
    And I should know it is equal to itself
    And I should know its' tag name is "input"
    And I should know the attribute "readonly" is false
  
  Scenario: Div element methods
    When I retrieve the div element
    Then I should know it exists
    And I should know it is visible
    And I should know its' text is "page-object rocks!"
    And I should know its' value is nil
    And I should know it is equal to itself
    And I should know its' tag name is "div"
    And I should know the attribute "readonly" is false

