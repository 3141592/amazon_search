README

Date:   10/24/2015

OS:     CentOS 7

Scenario:

  >Given I am on the Amazon home page

  >When I search for a iPhone 6 plus case

  >And I sort it by price from lowest to highest

  >Then I return the name and price of the top 3 results

  >extra: Return the name and price of the top 3 results with the best reviews.

To execute:

  >$ git clone https://github.com/3141592/amazon_search.git
  
  >$ cd amazon_search
  
  >$ cucumber
  

Output:

````
[chef-client amazon_search]$ cucumber
Feature: Automation test

  Scenario: A user goes to amazon.com and searches for iphone 6 plus case # features/amazon_search.feature:2
    Given I am on the Amazon home page                                    # features/step_definitions/amazon_search.rb:31
    When I search for "iPhone 6 plus case"                                # features/step_definitions/amazon_search.rb:39
    And I sort it by price from lowest to highest                         # features/step_definitions/amazon_search.rb:47
    Then I return the name and price of the top 3 results                 # features/step_definitions/amazon_search.rb:57
      iPhone 6 Plus / 6S Plus 5.5″ Case,DIOS CASE(TM) Gradient Ramp Translucent Lightweight Clear Slim fit Flexible...
      $0.01
      ----------------------------------------
      iPhone 6 Case, [Clear] K-Defense® Ultra Hybrid Crystal Clear hard back panel and soft protective bumper phone...
      $0.01
      ----------------------------------------
      iPhone 6 Plus / iPhone 6S Plus Screen Protector, MPERO Collection Ultra Clear Screen Protector for Apple iPhone...
      $0.01
      ----------------------------------------
    Then I sort it by Avg. Customer Review                                # features/step_definitions/amazon_search.rb:62
    Then I return the name and price of the top 3 results                 # features/step_definitions/amazon_search.rb:57
      LABC - Cable & Ultra Protection Case - Apple Certified MFi Lightning Cable in Case - iPhone 6 PLUS & 6S PLUS (...
      $24.99
      ----------------------------------------
      LABC Case with Apple-Certified MFi Cable & Ultra Protection Case - iPhone 6 & 6S (Navy Blue)
      $24.99
      ----------------------------------------
      LABC Case with Apple-Certified MFi Cable & Ultra Protection Case - iPhone 6 Plus (Navy)
      $24.99
      ----------------------------------------

1 scenario (1 passed)
6 steps (6 passed)
1m0.737s
````
