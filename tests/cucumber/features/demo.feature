Feature: I need the ability to display text upside down

  As a mobile transaction agent
  I want to see some text upside down 
  So that I get hints of what my counterpart sees when they use my mobile terminal

  Scenario:
    Given I am on the home page
    When I see "Hello Tasmania" in the field "straight" 
    Then I should see "ɐıuɐɯsɐ┴ oןןǝH" the field "flippant".
