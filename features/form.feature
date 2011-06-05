Feature: Form

  Background:
    Given I am on the static elements page
  
  Scenario: Submitting a form
    When I locate the form by "id"
    Then I should be able to submit the form

  Scenario Outline: Locating a form on the page
    When I locate the form by "<search_by>"
    Then I should be able to submit the form

  Scenarios:
    | search_by |
    | id        |
    | class     |
    | xpath     |  

  @watir_only
  Scenario Outline: Locating a form on the page watir only
    When I locate the form by "<search_by>"
    Then I should be able to submit the form
  
  Scenarios:
    | search_by |
    | index     |

