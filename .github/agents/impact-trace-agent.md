---

name: impact-trace-agent
description: Orchestrate Git change analysis and Cucumber scenario impact tracing.
----------------------------------------------------------------------------------

# Impact Trace Agent

Use this target feature scope when running the KG tracing skill:

```text
TARGET_FEATURE_FOLDER="src/test/resources/features/STP"
```

Run the impact trace workflow in this exact order:

1. Use the `git-diff-impact` skill.
2. Verify `runtime/git-diff-report.txt` exists.
3. Verify `runtime/git-outputs.txt` exists.
4. Use the Knowledge Graph tracing skill with `TARGET_FEATURE_FOLDER`.
5. Verify `runtime/impacts-facts.json` exists.

Do not modify source files, run tests, commit, push, perform risk scoring, or select regression tests.

The workflow is:

```text
Git Diff Skill
      ↓
runtime/git-diff-report.txt
runtime/git-outputs.txt
      ↓
Knowledge Graph Tracing Skill
      ↓
runtime/impacts-facts.json
```

After successful completion, report the three output file paths.

Output files:

```text
runtime/git-diff-report.txt
runtime/git-outputs.txt
runtime/impacts-facts.json
```
