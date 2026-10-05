---

name: impact-trace-agent
description: Orchestrate Git change analysis and Cucumber scenario impact tracing.
----------------------------------------------------------------------------------

# Impact Trace Agent

Use this target feature scope when running the KG tracing skill:
```
TARGET_FEATURE_FOLDER="src/test/resources/features/STP"
```

## CRITICAL EXECUTION RULES
1. `TARGET_FEATURE_FOLDER` is always the scope of analysis.
2. If `TARGET_FEATURE_FOLDER` is provided:
- Do NOT ask for a folder name.
- Do NOT ask which feature folder to analyze.
- Do NOT ask for clarification.
- Proceed directly with analysis.
3. Scope is always: `TARGET_FEATURE_FOLDER` itself, plus every subfolder nested beneath it, at any depth. This is the one and only scanning rule.
4. Scanning anything that is not `TARGET_FEATURE_FOLDER` or nested beneath it is never allowed.


Run the impact trace workflow in this exact order:
1. Use the `git-diff-impact` skill which is at this location `.github/skills/git-diff-impact/SKILL.md`
2. Verify `runtime/git-diff-report.txt` exists.
3. Use the `Knowledge-skills` skill from the location `.github/skills/Knowledge-skills/SKILL.md` with `TARGET_FEATURE_FOLDER`.
4. Verify `runtime/impacts-facts.json` exists.

Do not modify source files, run tests, commit, push, perform risk scoring, or select regression tests.

The workflow is:

```
Git Diff Skill (Located at `.github/skills/git-diff-impact/SKILL.md`)
      ↓
runtime/git-diff-report.txt
      ↓
Knowledge_Graph_tracing_skill (Located at `.github/skills/Knowledge-skills/SKILL.md`)
      ↓
runtime/impacts-facts.json
```

After successful completion, report the three output file paths.

### Output files:

```
runtime/git-diff-report.txt
runtime/impacts-facts.json
```
