---

name: git-diff-impact
description: Identify changed Java files, methods, and Cucumber step definitions between origin/main and HEAD for impact analysis.
----------------------------------------------------------------------------------------------------------------------------------

# Git Diff Agent

Compare `origin/main` to `HEAD` using only:

```text
src/main/java
src/test/java
```

## Identify Only:

* Changed files and change type (Added/Modified/Deleted)
* Changed classes and their location
* Changed methods/constructors/fields with line ranges
* Which lines changed (with diff hunks)
* Direct method calls within the changed lines

## Use These Commands:

```bash
git diff --name-status origin/master HEAD -- src/main/java src/test/java
git diff origin/master HEAD -- src/main/java src/test/java
git diff --stat origin/master HEAD -- src/main/java src/test/java
```

## Scope Rules:

**DO:**
* Report changed files, classes, and methods
* Report line ranges of changes
* Report method calls in changed lines
* Provide clear, structured output

**DO NOT:**
* Track Cucumber step definitions or their changes
* Perform impact analysis
* Identify impacted scenarios
* Recommend regression subsets
* Modify source code, run tests, commit, or push

## Output:

Write the result to:

```text
runtime/git-diff-report.txt
```

Create the `runtime` directory if required and verify the report exists before completing.
