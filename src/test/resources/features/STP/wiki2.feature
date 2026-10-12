Feature: Wiki search
  As a non logged in user I should be able to do search on Wikipedia.

Scenario: Search for Software testing in Hebrew
Given I navigate to "https://www.wikipedia.org/"
And I select "he" option by value from dropdown having id "searchLanguage"
When I enter "בדיקת תוכנה" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "בדיקת"
And I navigate back
Then I close browser

Scenario: Search for Automation in Arabic
Given I navigate to "https://www.wikipedia.org/"
And I select "ar" option by value from dropdown having id "searchLanguage"
When I enter "الأتمتة" into input field having id "searchInput"
And I click on element having class "pure-button-primary-progressive"
Then I should see page title having partial text as "الأتمتة"
And I navigate back
Then I close browser