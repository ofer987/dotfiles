# ado-pr-title

Skill that ties GitHub pull requests to Azure DevOps (ADO) work items. When the checked-out branch
belongs to an ADO ticket, Claude:

1. Titles the PR `[AB#<ADO_NUMBER>] <short_title>`, so Azure Boards links the PR to the work item.
2. Starts the PR description with a link to the work item, `[AB#<ADO_NUMBER>](<ADO_WORK_ITEM_URL>)`.
3. Labels the new PR `AI Generated`.
4. After the PR is created, saves the PR URL in the ticket's **GitHub Pull Request URL** field
   (`Custom.GitHubPullRequestURL`).

Example title: `[AB#1363516] Skip CI/CD - Releases if version is already deployed`.

The skill is guidance that Claude follows. To enforce the title format, see the companion hook in
[`hooks/general/ado-pr-title-check`](../../../hooks/general/ado-pr-title-check/README.md).

## Files

| File       | Purpose                                                        |
| ---------- | -------------------------------------------------------------- |
| `SKILL.md` | The skill: title format, workflow and notes that Claude reads. |

## When it applies

Claude uses the skill when you create or retitle a GitHub PR for an ADO work item, ticket, story or
bug, or mention an `AB#` number.

It only applies when the checked-out branch name starts with a ticket number, matching
`^[A-Za-z]+[-_#](\d+)`: letters, one of `-`, `_` or `#`, then digits. For example `ab-1386549-ai-skill`
and `AB#123-fix` give tickets 1386549 and 123. Any other branch (including `feature/ab-123`) is
assumed not to be for an ADO ticket and is left alone. On such a branch Claude doesn't put an
`[AB#<number>]` prefix in the title, and the hook blocks one if it does.

## What it does

| Step | Action |
| ---- | ------ |
| 1 | Reads the ticket number from the checked-out branch name. |
| 2 | Confirms the ticket exists with `get_work_item` and notes the ticket's `url` for the PR body link. If it doesn't exist, Claude tells you and asks how to proceed. |
| 3 | If you gave no title, derives a short one from the ticket title or the diff. If the repository has a `.github/pull_request_template.md`, reads it so the description can follow it. |
| 4 | Creates the PR with `create_pull_request` (or retitles it with `update_pull_request`) using the format below, with the body starting with the ticket link. The number must equal the branch's ticket number. A different number is never allowed (the hook blocks it): Claude points out the mismatch and asks you to switch to a branch named for that ticket. |
| 5 | After creation only, adds the `AI Generated` label to the PR, keeping any labels it already has. |
| 6 | After creation only, sets `Custom.GitHubPullRequestURL` on the ticket to the PR URL, replacing any existing value (including "Not Applicable"), and tells you. |

### Title format

```
[AB#<ADO_NUMBER>] <short_title>
```

The title must match `^\[AB#\d+\] \S.*$`: uppercase `AB#`, digits only, one space, then a non-empty
title. The short title should be a brief, imperative summary (under about 70 characters in total),
without the ticket's full title or a conventional-commit prefix such as `fix(ci):`.

### Body format

The PR body starts with a link to the work item, then a blank line, then the rest of the description:

```
[AB#<ADO_NUMBER>](https://dev.azure.com/<org>/<project>/_workitems/edit/<ADO_NUMBER>)

<rest of the description>
```

The URL comes from the `url` field of the `get_work_item` response, and the number must equal the one
in the title and the branch.

If the repository has a `.github/pull_request_template.md`, the rest of the description follows that
template (its headings, order and checklists, every section filled in, "N/A" where a section doesn't
apply), with the ticket link kept as the first line above it. Without a template the description is
the ticket link followed by these sections:

```
## Description

## Tests

## Related changes
```

`Description` says what changed and why. `Tests` says how it was tested and is omitted if not relevant.
`Related changes` lists related PRs, tickets or follow-ups, or "None".

## Installation

Copy the `ado-pr-title` folder into your skills directory, for example:

```bash
mkdir -p ~/.claude/skills
cp -R ado-pr-title ~/.claude/skills/
```

Use `.claude/skills/` in a repository to share it with that project only.

## Requirements

- The GitHub MCP server (`create_pull_request`, `update_pull_request`, `pull_request_read` and `issue_write`). The skill tells Claude not
  to use `gh` or other Bash commands to create or edit the PR.
- The `ADO_MCP_SERVER` MCP server (`get_work_item`, `get_work_item_type_fields`, `update_work_item`).
- A work item type that has the `Custom.GitHubPullRequestURL` field, to record the URL.

## Testing

Try these in a repository, on a branch named for a ticket that exists (for example
`ab-1363516-demo`):

| Ask Claude to | Expected |
| ------------- | -------- |
| Open a PR for the current changes | Looks up the ticket, creates the PR titled `[AB#1363516] <short_title>` whose body starts with `[AB#1363516](https://dev.azure.com/.../_workitems/edit/1363516)` followed by a blank line, then adds the `AI Generated` label (keeping existing labels), sets the ticket's GitHub Pull Request URL and tells you. |
| Open a PR titled `[AB#999] something` | Refuses: points out the number differs from the branch (1363516), does not create the PR, and asks you to switch to a branch named for ticket 999 (or use `[AB#1363516]`). With the hook installed the call is blocked even if Claude tries it. |
| Open a PR titled `[AB#1363516] something` from `main` or `feature/ab-123` | Refuses: the branch has no ticket number, so the title can't match it. Claude drops the prefix or asks for a ticket branch. |
| Open a PR and describe it in your own words | The description still starts with the `[AB#1363516](<ticket URL>)` link; your text follows after a blank line. The URL is the one `get_work_item` returned, not a guess. |
| Retitle the PR to something else | Keeps the `[AB#1363516] ` prefix. The ticket URL is not updated. |
| Open a PR in a repository that has `.github/pull_request_template.md` | The body starts with the ticket link, then a blank line, then the template's sections in order, all filled in. In a repository without a template (such as this one) the body is the ticket link, then `## Description`, `## Tests` (if relevant) and `## Related changes`. |
| Open a PR from a branch with a nonexistent ticket number | Tells you the ticket doesn't exist and asks how to proceed. |
| Open a PR from `main` or `feature/ab-123` | Does nothing special: no `[AB#...]` format, no URL recording, and no `[AB#...]` prefix in the title. |

### End-to-end run on a throwaway branch

The prompts above create real PRs and overwrite a real ticket field, so do not run them on a branch
that already has a PR. This is how the skill was validated without touching real work. It assumes
the companion hook is installed, so its blocks are exercised too. Use a ticket you can safely edit.

1. **Offline checks.** In Python, confirm the branch regex `^[A-Za-z]+[-_#](\d+)` and the title
   pattern `^\[AB#\d+\] \S.*$` accept and reject the examples in this README (`ab-1386549-x` and
   `AB#123-fix` match; `main`, `feature/ab-123` and `1234-x` do not; `[AB#123]Fix`, `[ab#123] x` and
   `[AB#123] ` are rejected). Also confirm a body check accepts
   `[AB#123](https://dev.azure.com/o/p/_workitems/edit/123)` as its first line and rejects a body
   with no link, a link with a different number, or the link not on the first line.
2. **Read-only lookups.** Call `get_work_item` for the branch's ticket (it returns the ticket) and
   for a number that does not exist, such as `999999999` (it returns `TF401232 ... does not exist`).
   Note the ticket's current `Custom.GitHubPullRequestURL` so you can restore it later.
3. **Throwaway branch.** Use a separate worktree so your own work is untouched, and name the branch
   for the ticket:
   ```bash
   git worktree add <dir> -b ab-<ticket>-skilltest-tmp origin/main
   cd <dir> && echo "temporary skill test" > skilltest-tmp.txt
   git add skilltest-tmp.txt && git commit -m "test: temporary file for ado-pr-title validation"
   git push origin HEAD:refs/heads/ab-<ticket>-skilltest-tmp
   ```
   Push with the explicit `HEAD:refs/heads/...` form. A branch created from `origin/main` tracks
   `main`, so a bare `git push` targets `main` (a protected or non-fast-forward `main` rejects it,
   but do not rely on that).
4. **Create.** In that worktree, follow the skill: create a **draft** PR titled
   `[AB#<ticket>] <short_title>` from the throwaway branch, with a body that starts with
   `[AB#<ticket>](<ticket URL>)` and a blank line. With the hook installed, the first call is blocked
   once until you confirm the ticket with `get_work_item`, and a body without the link is blocked too;
   fix and retry and it goes through. Read the PR back and confirm the body's first line is the link.
5. **Record the URL.** Follow the hook's prompt (or step 6 of the skill): `get_work_item`, then
   `get_work_item_type_fields` for the ticket's type, then `update_work_item` with
   `custom_fields={"Custom.GitHubPullRequestURL": "<PR URL>"}`. The type-fields list may not include
   this field even though the ticket has it, and the update still succeeds. Read the ticket back to
   confirm the new value.
6. **Retitle.** Step 4 already calls `pull_request_read`, which records the PR's head for the session,
   so a retitle in the same session is not blocked for a missing read. Test the missing-read guard
   separately, in a fresh session (a new Claude session, or a new `session_id` when piping events to the
   hook): try `update_pull_request` with a new title before any `pull_request_read` and the hook blocks
   it. Then, in the session that has read the PR (call `pull_request_read` with method `get` if
   needed), try a title with another ticket number (blocked), then a valid `[AB#<ticket>] ...` title
   (allowed). The ticket's URL is not updated by a retitle.
7. **Label.** After creation the PR should carry `AI Generated`, with any labels it already had kept.
   This repository may add the label automatically, in which case the skill's step is skipped.
8. **Clean up.** Restore the ticket's original `Custom.GitHubPullRequestURL`, close the PR, delete the
   remote and local branches, and remove the worktree:
   ```bash
   git push origin --delete ab-<ticket>-skilltest-tmp
   git worktree remove --force <dir> && git branch -D ab-<ticket>-skilltest-tmp
   ```

Closing the PR leaves it in GitHub's history, and ADO's change history for the ticket shows both
URL edits.
