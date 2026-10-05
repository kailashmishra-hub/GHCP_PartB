# Impact Workflow Mapping

This document describes the desired workflow for mapping a changed Java method back to the Cucumber scenarios that may be impacted.

## Scope

The mapper should scan these repository areas:

```text
src/main/java
src/test/java
src/test/resources
```

The Java scan should include every `.java` class under `src/main/java` and `src/test/java`.

The feature scan should include every `.feature` file under `src/test/resources`.

## Goal

When a method changes, trace upward through callers until a Cucumber step definition is reached. Then match that step definition to feature-file steps and identify the impacted scenario.

The workflow should look like this:

```text
Changed method
   ^
Caller method
   ^
Step definition method
   ^
@Given/@When/@Then/@And annotation
   ^
Feature step
   ^
Scenario
```

If the changed method is nested deeper, keep walking upward through all callers:

```text
Changed method
   ^
Helper method
   ^
Page/action method
   ^
Step definition method
   ^
Cucumber annotation
   ^
Feature step
   ^
Scenario
```

## Example From This Repo

Feature step:

```gherkin
Scenario: Access homepage
Given I navigate to "www.homerunner.ng"
And I click on element having xpath "//button[text()='Get Started']"
And I switch to new window
Then element having xpath "//span[text()='Start']" should be present
```

Step definition:

```java
@Then("^I click on element having (.+) \"(.*?)\"$")
public void click(String type,String accessName) throws Exception
{
    miscmethodObj.validateLocator(type);
    clickObj.click(type, accessName);
    click_forcefully(type, accessName);
    System.out.println("I am on Elelemt page");
}
```

Called method:

```java
public void click(String accessType, String accessName)
{
    element = wait.until(ExpectedConditions.presenceOfElementLocated(getelementbytype(accessType, accessName)));
    element.click();
}
```

If `ClickElementsMethods.click()` changes, the expected trace is:

```text
ClickElementsMethods#click
   ^
PredefinedStepDefinitions#click
   ^
@Then("^I click on element having (.+) \"(.*?)\"$")
   ^
And I click on element having xpath "//button[text()='Get Started']"
   ^
Scenario: Access homepage
```

The same changed method also impacts other scenarios that use this feature step pattern, for example:

```text
ClickElementsMethods#click
   ^
PredefinedStepDefinitions#click
   ^
@Then("^I click on element having (.+) \"(.*?)\"$")
   ^
Given I click on element having xpath "//span[text()='Start']"
   ^
Scenario: Fill homerunner form
```

## Nested Helper Example

For a chain like this:

```java
@And("I click save")
public void saved() {
    performfooter.ss();
}
```

If `performfooter.ss()` changes, or if a method called by `ss()` changes, the expected trace is:

```text
Changed method
   ^
performfooter.ss()
   ^
saved()
   ^
@And("I click save")
   ^
Feature step
   ^
Scenario
```

## Matching Rules

The mapper should:

1. Match direct method calls in Java source.
2. Continue tracing through nested helper methods until a Cucumber step definition is found.
3. Support Cucumber annotations such as `@Given`, `@When`, `@Then`, and `@And`.
4. Match annotation expressions to feature steps.
5. Support common Cucumber expression placeholders such as `{string}`, `{int}`, `{float}`, and `{word}`.
6. Support regex-style step definitions such as `^I click on element having (.+) \"(.*?)\"$`.
7. Avoid broad substring matching because it can create false positives.
8. Trace all callers when a changed method is used by multiple step definitions.
9. Map a background step to every scenario in the feature.
10. Keep scenario results deduplicated.

## Suggested Markdown Output Format

Each impacted workflow can be documented like this:

```text
Changed Method:
  ClickElementsMethods#click

Call Chain:
  ClickElementsMethods#click
     ^
  PredefinedStepDefinitions#click
     ^
  @Then("^I click on element having (.+) \"(.*?)\"$")
     ^
  And I click on element having xpath "//button[text()='Get Started']"
     ^
  Scenario: Access homepage

Feature:
  src/test/resources/Homerunner Login.feature

Scenario Line:
  4

Feature Step Line:
  6
```

## Desired Result

For every changed method, the workflow document should answer:

```text
Which method changed?
Which method called it?
Which step definition is connected?
Which Cucumber annotation is connected?
Which feature step matched?
Which scenario is impacted?
```
