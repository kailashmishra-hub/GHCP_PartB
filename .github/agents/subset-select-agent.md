# Minimal Scenario Selection from Impact Analysis (Risk-Based Approach)

## Objective
From impacts-facts.json, select the MINIMUM set of scenarios that cover ALL impacted step definitions, prioritized by RISK LEVEL of the code changes.

## Input
- File: impacts-facts.json
- Contains: Array of impacted_scenarios with their step_definitions

## Algorithm
1. Extract all unique step_definitions across all scenarios
2. Assess RISK LEVEL for each step_definition:
    - **CRITICAL (100):** Step used in only 1-2 scenarios
    - **HIGH (75):** Step used in 3-5 scenarios
    - **MEDIUM (50):** Step used in 6-10 scenarios
    - **LOW (25):** Step used in 11+ scenarios
3. Calculate scenario risk score = average risk of all its steps
4. Remove duplicate scenarios (same feature_name + scenario_name)
5. Risk-based selection: prioritize highest-risk scenarios first
6. Continue until all step_definitions are covered
7. Classify remaining scenarios as excluded

## Output JSON

```json
{
  "summary": {
    "total_scenarios_analyzed": <number>,
    "selected_scenarios": <number>,
    "excluded_scenarios": <number>,
    "total_step_definitions_covered": <number>,
    "risk_coverage": {
      "critical_steps_covered": "<count>/<total>",
      "high_risk_steps_covered": "<count>/<total>",
      "medium_risk_steps_covered": "<count>/<total>",
      "low_risk_steps_covered": "<count>/<total>"
    }
  },
  
  "selected_scenarios": [
    {
      "rank": 1,
      "feature_name": "Feature Name",
      "scenario_name": "Scenario Name",
      "feature_path": "src/test/resources/...",
      "scenario_line": <number>,
      "tags": [],
      "step_definitions": [
        "package.Class#method1",
        "package.Class#method2"
      ],
      "scenario_risk_score": 85,
      "critical_steps_count": 2,
      "high_risk_steps_count": 1,
      "trace_reason": "Risk-based selection. Scenario risk score: 85. Contains 2 CRITICAL and 1 HIGH-risk steps. Rank 1: Highest risk priority - essential to mitigate code change impact."
    },
    {
      "rank": 2,
      "feature_name": "...",
      "scenario_name": "...",
      "feature_path": "...",
      "scenario_line": <number>,
      "tags": [],
      "step_definitions": [
        "package.Class#method3"
      ],
      "scenario_risk_score": 50,
      "critical_steps_count": 0,
      "high_risk_steps_count": 0,
      "trace_reason": "Risk-based selection. Scenario risk score: 50. Covers MEDIUM-risk step not covered by rank 1. Secondary priority - completes coverage."
    }
  ],
  
  "excluded_scenarios": [
    {
      "feature_name": "Feature Name",
      "scenario_name": "Scenario Name",
      "feature_path": "src/test/resources/...",
      "scenario_line": <number>,
      "step_definitions": [
        "package.Class#method1",
        "package.Class#method2"
      ],
      "scenario_risk_score": 100,
      "trace_reason": "Duplicate of selected scenario at line X. All step definitions already covered by higher/equal priority scenarios."
    },
    {
      "feature_name": "...",
      "scenario_name": "...",
      "feature_path": "...",
      "scenario_line": <number>,
      "step_definitions": [
        "package.Class#method4"
      ],
      "scenario_risk_score": 25,
      "trace_reason": "Low risk priority. Contains only LOW-risk steps already covered by higher-risk scenarios. Not essential for mitigating code change impact."
    }
  ]
}