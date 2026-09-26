# Cucumber Tracer Skill

Trace changed Cucumber step definitions to the feature scenarios that use them.

Also trace changes made inside methods called by a Cucumber step definition, including nested/helper methods, and trace those changes back to the Cucumber step definition and ultimately to the impacted feature scenarios.

## Input

Read:

`runtime/git-diff-report.txt`

This file contains the Cucumber step definitions and code changes identified by the Git Diff Skill.

Example:

```text
Step definitions changed:
- @Then("user should see all the booking IDs") -> userShouldSeeAllTheBookingIDS()
- @When("user creates a booking") -> userCreatesABooking()
```

## Task

For every changed step definition or changed method:

1. Extract its Cucumber annotation and expression when applicable.
2. Find matching Cucumber steps in feature files under `src/test/resources`.
3. Identify the scenario or scenario outline containing each matching step.
4. If a changed step is in a `Background`, mark every scenario in that feature as impacted.
5. If multiple changed step definitions affect the same scenario, create only one scenario entry and list all impacted steps under it.
6. If the same changed step appears multiple times in a scenario, keep one impacted-step entry and merge all matching line numbers.
7. Preserve feature name, scenario name, scenario line number, and scenario tags where available.
8. Record changed step definitions that have no matching feature step under `unresolved_step_definitions`.
9. If a changed method is called by a Cucumber step definition, trace the call chain back to that step definition and then to the feature scenarios using that step.
10. Continue tracing through nested/helper methods. For example:

```java
@And("I click save")
public void saved() {
    performfooter.ss();
}
```

If `performfooter.ss()` or a method called by `ss()` is changed, trace:

```text
Changed method
    ↑
performfooter.ss()
    ↑
saved()
    ↑
@And("I click save")
    ↑
Feature step
    ↑
Scenario
```

11. Trace all identifiable callers when a changed method is used by multiple methods or step definitions.
12. Do not stop tracing simply because the changed code is not directly inside the Cucumber step-definition method.

## Matching

Match Cucumber expressions accurately.

Support:

* `{string}`
* `{int}`
* `{float}`
* `{word}`

Also support regex-style step definitions beginning with `^` or ending with `$`.

Do not use broad substring matching that can produce false matches.

For code-impact tracing, identify actual method calls from the source code. Do not infer relationships only from similar method or class names.

## Scope

Inspect only:

* `runtime/git-diff-report.txt`
* changed step-definition files referenced by that report
* source files required to trace changed methods back to their callers
* Cucumber feature files under `src/test/resources`

Do not perform code review, refactoring, test execution, regression selection, commits, pushes, or source-code modifications.

## Output

Create or overwrite:

`runtime/impacts-facts.json`

Create the `runtime` directory if necessary.

Use this structure:

```json
{
  "schema_version": "trace-impact-agent/v2",
  "source_file": "runtime/git-diff-report.txt",
  "impacted_scenarios": [
    {
      "feature_path": "src/test/resources/features/example.feature",
      "feature_name": "Feature name",
      "scenario_name": "Scenario name",
      "scenario_line": 10,
      "tags": ["@regression"],
      "impacted_steps": [
        {
          "matched_step": "user should see all the booking IDs",
          "matched_step_lines": [14],
          "matched_step_source": "Scenario",
          "step_definition": "com.api.stepdefinition.ViewBookingDetailsStepdefinition#userShouldSeeAllTheBookingIDS",
          "annotation": "@Then(\"user should see all the booking IDs\")",
          "reason": "Scenario contains a feature step matching a changed step definition."
        }
      ]
    }
  ],
  "unresolved_step_definitions": [
    {
      "annotation": "@Then(\"example\")",
      "method": "exampleMethod",
      "reason": "No matching feature step was found."
    }
  ]
}
```

When impact is discovered through an inner/helper method, include the call chain in the impacted step where possible.

Example:

```json
"call_chain": [
  "FooterSteps#saved",
  "performfooter#ss",
  "FooterActions#save"
]
```

The call chain should show the path from the Cucumber step definition to the changed method.

## Deduplication

A scenario must appear only once.

Use `feature_path + scenario_line` to identify the same scenario.

Within `impacted_steps`, use one entry per changed step definition.

If the same scenario is impacted through multiple methods or call paths, merge the impact into the existing scenario instead of creating a duplicate scenario.

## Completion

Do not finish until `runtime/impacts-facts.json` has been created or overwritten with valid JSON.

After completing the file write, respond only:

`Impacted scenarios: <count>`
`Unresolved step definitions: <count>`
`Output file: runtime/impacts-facts.json`
