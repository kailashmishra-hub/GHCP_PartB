---

name: git-diff-impact
description: Identify changed Java files, methods, and Cucumber step definitions between origin/main and HEAD for impact analysis.
----------------------------------------------------------------------------------------------------------------------------------

# Git Diff Impact

Compare `origin/main` to `HEAD` using only:

```text
src/main/java
src/test/java
```

Identify:

* changed files and change type
* changed classes/methods/fields
* changed Cucumber step definitions and annotations

Use:

```text
git diff origin/main HEAD -- src/main/java src/test/java
```

Do not modify source code, run tests, commit, push, or perform scenario/risk analysis.

Write the result to:

```text
runtime/git-diff-report.txt
```

Create the `runtime` directory if required and verify the report exists before completing.
