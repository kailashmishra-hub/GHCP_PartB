---

name: impact-trace-agent
description: Orchestrate Git change analysis and Cucumber scenario impact tracing.
----------------------------------------------------------------------------------

# Impact Trace Agent

Run the impact trace workflow in this exact order:

1. Use the `git-diff-impact` skill.
2. Verify `runtime/git-diff-report.txt` exists.
3. Use the `cucumber-impact-tracing` skill.
4. Verify `runtime/impacts-facts.json` exists.

Do not modify source files, run tests, commit, push, perform risk scoring, or select regression tests.

The workflow is:

```text
Git Diff Skill
      ↓
runtime/git-diff-report.txt
      ↓
Cucumber Trace Skill
      ↓
runtime/impacts-facts.json
```

After successful completion, report the two output file paths.
