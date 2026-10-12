Feature: Wiki search
  As a non logged in user I should be able to do search on Wikipedia.



  Scenario: Search for Cybersecurity in English
Given I navigate to "https://www.wikipedia.org/"
And I select "en" option by value from dropdown having id "searchLanguage"
When I enter "Cybersecurity" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "Cybersecurity"
And I navigate back
Then I close browser

Scenario: Search for HTML in English
Given I navigate to "https://www.wikipedia.org/"
And I select "en" option by value from dropdown having id "searchLanguage"
When I enter "HTML" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "HTML"
And I navigate back
Then I close browser

Scenario: Search for CSS in English
Given I navigate to "https://www.wikipedia.org/"
And I select "en" option by value from dropdown having id "searchLanguage"
When I enter "CSS" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "CSS"
And I navigate back
Then I close browser

Scenario: Search for Wikipedia in English
Given I navigate to "https://www.wikipedia.org/"
And I select "en" option by value from dropdown having id "searchLanguage"
When I enter "Wikipedia" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "Wikipedia"
And I navigate back
Then I close browser

Scenario: Search for India in English
Given I navigate to "https://www.wikipedia.org/"
And I select "en" option by value from dropdown having id "searchLanguage"
When I enter "India" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "India"
And I navigate back
Then I close browser

Scenario: Search for Earth in English
Given I navigate to "https://www.wikipedia.org/"
And I select "en" option by value from dropdown having id "searchLanguage"
When I enter "Earth" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "Earth"
And I navigate back
Then I close browser

Scenario: Search for Programming in French
Given I navigate to "https://www.wikipedia.org/"
And I select "fr" option by value from dropdown having id "searchLanguage"
When I enter "Programmation" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "Programmation"
And I navigate back
Then I close browser



Scenario: Search for Artificial intelligence in German
Given I navigate to "https://www.wikipedia.org/"
And I select "de" option by value from dropdown having id "searchLanguage"
When I enter "Künstliche Intelligenz" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "Künstliche"
And I navigate back
Then I close browser

Scenario: Search for Automation in Spanish
Given I navigate to "https://www.wikipedia.org/"
And I select "es" option by value from dropdown having id "searchLanguage"
When I enter "Automatización" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "Automatización"
And I navigate back
Then I close browser

Scenario: Search for Testing in Italian
Given I navigate to "https://www.wikipedia.org/"
And I select "it" option by value from dropdown having id "searchLanguage"
When I enter "Test software" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "Test"
And I navigate back
Then I close browser

