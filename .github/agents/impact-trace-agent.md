---

name: impact-trace-agent
description: Orchestrate Git change analysis and Cucumber scenario impact tracing.
----------------------------------------------------------------------------------

# Impact Trace Agent

Run the impact trace workflow in this exact order:

1. Verify `runtime/git-diff-report.txt` exists.
2. Use the `.github/skills/cucumber-impact-tracing/SKILL.md` skill.
3. Verify `runtime/impacts-facts.json` exists.

Do not modify source files, run tests, commit, push, perform risk scoring, or select regression tests.

The workflow is:

.github/agents/Git-Diff-agent.md
      ↓
runtime/git-diff-report.txt
      ↓
.github/skills/cucumber-impact-tracing/SKILL.md
      ↓
runtime/impacts-facts.json


After successful completion, report the two output file paths.
