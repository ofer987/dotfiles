---
name: release-branch-validator
description: Validates that a release branch is the latest patch for its series and contains the full patch ancestry. Use when on a releases/<MAJOR>.<MINOR>.<PATCH> branch and the user asks to validate the release, check release history, verify patch chain, or audit release branch integrity.
disable-model-invocation: true
---

# Release Branch Validator

Performs two validations on the current `releases/<MAJOR>.<MINOR>.<PATCH>` branch:

1. **Latest patch check** — confirms that no higher patch branch exists on the remote for this `<MAJOR>.<MINOR>` series.
2. **Ancestor merge check** — confirms that every preceding patch branch that exists on the remote has been merged into the current branch.

Branches that do not exist on the remote are silently skipped — only branches that exist but were **not merged** cause a failure.

## Prerequisites

- The current branch must match the pattern `releases/<MAJOR>.<MINOR>.<PATCH>`.
- If the current branch does not match, stop and tell the user this skill only applies to release branches. Suggest they check out one first, e.g. `git checkout releases/5.80.101`.

## Workflow

### Step 1: Identify the current release branch

```bash
git rev-parse --abbrev-ref HEAD
```

Parse the branch name to extract `MAJOR`, `MINOR`, and `PATCH`. If the branch is not in the form `releases/<MAJOR>.<MINOR>.<PATCH>`, report an error and suggest the user check out a release branch first, e.g.:

```
git checkout releases/5.80.101
```

Then stop.

### Step 2: Fetch remote refs and discover existing branches

Fetch the relevant remote refs for the entire `<MAJOR>.<MINOR>` series, then list all patch branches that exist on the remote:

```bash
git fetch origin --prune 'refs/heads/releases/<MAJOR>.<MINOR>.*:refs/remotes/origin/releases/<MAJOR>.<MINOR>.*'
git branch -r --list 'origin/releases/<MAJOR>.<MINOR>.*'
```

Parse the patch number from each listed branch.

### Step 3: Validate that the current branch is the latest patch

From the branches discovered in Step 2, find the highest patch number. If any branch has a patch number **greater than** `PATCH`, the current branch is **not the latest** — report a failure:

```
Release Branch Validation: FAILED

Branch:         releases/<MAJOR>.<MINOR>.<PATCH>
Latest remote:  releases/<MAJOR>.<MINOR>.<HIGHEST>

The checked-out branch is not the latest patch release for this series.
Check out the latest branch:

  git checkout releases/<MAJOR>.<MINOR>.<HIGHEST>
```

After reporting, exit with a non-zero code using the Shell tool (e.g. `exit 1`) and **stop** — do not proceed to the ancestor merge check.

If the current branch **is** the latest (no higher patch exists on the remote), continue to Step 4.

### Step 4: Check merge status of each existing preceding branch

From the branches discovered in Step 2, keep only those with a patch number from `0` to `PATCH - 1`.

For each existing preceding branch, resolve its commit and verify it is an ancestor of HEAD:

```bash
sha=$(git rev-parse "origin/releases/<MAJOR>.<MINOR>.<N>")
git merge-base --is-ancestor "$sha" HEAD
```

If `merge-base --is-ancestor` returns non-zero, mark it as **not merged**.

### Step 5: Report results

#### All existing ancestors merged

```
Release Branch Validation: PASSED

Branch:    releases/<MAJOR>.<MINOR>.<PATCH>  (latest)
Checked:   <N> existing preceding patch branches — all merged

  releases/<MAJOR>.<MINOR>.0  ✓
  releases/<MAJOR>.<MINOR>.1  ✓
  ...
```

#### One or more existing ancestors not merged

```
Release Branch Validation: FAILED

Branch:       releases/<MAJOR>.<MINOR>.<PATCH>  (latest)
Not merged:   <count> of <N> existing preceding patch branches

  releases/<MAJOR>.<MINOR>.0   ✓
  releases/<MAJOR>.<MINOR>.1   ✗  (not merged)
  releases/<MAJOR>.<MINOR>.2   ✓
  ...
```

After reporting, exit with a non-zero code if any existing branch was not merged. Use the Shell tool with a failing command like `exit 1` so the result is clearly a failure.

### Step 6: Edge case — patch version is 0

If the current branch is `releases/<MAJOR>.<MINOR>.0` and it is the latest (Step 3 passed), there are no preceding patches to validate. Report:

```
Release Branch Validation: PASSED (baseline)

Branch:   releases/<MAJOR>.<MINOR>.0  (latest)
This is the baseline patch release — no preceding patches to validate.
```
