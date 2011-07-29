Feature: Handling frames

  Background:
    Given I am on the frame elements page

  Scenario: Switching to a frame by id
    When I switch to a frame using id "frame_2"
    Then I should see "Frame 2" in the frame

  Scenario: Switching to a frame by index
    When I switch to a frame using index "1"
    Then I should see "Frame 2" in the frame