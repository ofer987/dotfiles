---
name: ado-pr-title
description: Format GitHub Pull Request titles as "[AB#<ADO_NUMBER>] <short_title>" for work tied to an Azure DevOps (ADO) ticket. Use when creating or retitling a GitHub PR for an ADO work item, ticket, story, or bug, or when the user mentions AB# numbers.
---

# ADO Pull Request Title

## Format

```
[AB#<ADO_NUMBER>] <short_title>
```

- `<ADO_NUMBER>`: the numeric ADO work item ID, no `#` or spaces inside the brackets.
- `<short_title>`: a brief, imperative summary of the change (aim for under ~70 characters total). Do not repeat the ticket's full title or add a conventional-commit prefix like `fix(ci):`.

Examples:

- `[AB#1363516] Skip CI/CD - Releases if version is already deployed`
- `[AB#1402200] Add retry to bundle upload`

## Workflow

1. Find the ADO number, in this order:
   - The number the user gave (accept `AB#123`, `#123`, or `123`).
   - The current Git branch name (e.g. `ab-1363516-...`, `AB#1363516/...`, `feature/1363516-...`).
   - Otherwise ask the user. Never guess.
2. If the short title isn't given, derive it from the ticket title (look it up with the `ado-work-item-info` skill or the ADO MCP `get_work_item` tool if available) or from the diff, then shorten it.
3. Apply the format when creating the PR (`gh pr create --title ...` or the GitHub MCP `create_pull_request`), and when retitling an existing PR.
4. If the user explicitly supplies a different number or title, use theirs as given. Mention it if it conflicts with the ticket number in the branch name or commit.

## Notes

- The `AB#<number>` in the title lets Azure Boards link the PR to the work item.
- Keep the PR body's reference to the ticket consistent with the title's number.
