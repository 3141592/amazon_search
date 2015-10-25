Feature: Automation test
  Scenario: A user goes to amazon.com and searches for iphone 6
    Given I am on the Amazon home page
    When I search for "iPhone 6 plus case"
    And I sort it by price from lowest to highest
    Then I return the name and price of the top 3 results
    Then I sort it by Avg. Customer Review
    Then I return the name and price of the top 3 results
