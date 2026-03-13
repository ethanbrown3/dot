---
name: ship
description: Create a PR from current changes, run specialized review agents (bug hunter, test reviewer, quality reviewer, and optionally spec writer) in parallel, address their findings, and push updates. Full ship workflow in one command.
user-invocable: true
argument-hint: "[base-branch]"
---

Ship the current changes through a full PR review cycle. This is a multi-phase workflow:

1. **Create PR** from current branch changes
2. **Launch review agents** in parallel on the PR (3 core + optional spec-writer)
3. **Triage and fix** their findings
4. **Push updates** to the PR

If a PR already exists for the current branch, skip step 1 and review the existing PR.

## Phase 1: Create PR

Check if a PR already exists for the current branch:
```bash
gh pr view --json number,url 2>/dev/null
```

If no PR exists:
- Determine the base branch. Use `$ARGUMENTS` if provided, otherwise default to `main`.
- Look at the full commit history on this branch vs the base branch to understand ALL changes
- Create a new branch if still on main/master (name it after the work being done)
- Commit any uncommitted changes with a descriptive message
- Push the branch
- Create the PR with a summary and test plan using `gh pr create`

Capture the PR number for the next phase.

## Phase 2: Parallel Review

### Determine which agents to launch

First, classify the PR by checking what types of files changed:

```bash
gh pr diff {number} --name-only
```

Classify each file:
- **Code files**: `*.py`, `*.js`, `*.ts`, `*.rs`, `*.go`, `*.java`, etc. Also test files.
- **Spec files**: anything under `openspec/` or `.openspec` files
- **Config/docs**: `*.md` (outside openspec/), `*.yaml`, `*.toml`, `.gitignore`, etc.

**If the PR contains ANY code files**, launch the 3 core agents:
- Bug Hunter
- Test Reviewer
- Quality Reviewer

**If the PR is spec-only** (all changed files are under `openspec/`, or are `.openspec.yaml` files, with no code files), launch ONLY the Spec Writer agent. The code review agents have nothing useful to review on prose-only PRs.

**Conditionally launch Spec Writer** (in addition to core agents) if ANY of the following are true:
- The diff includes files under `openspec/` (proposals, specs, designs, tasks)
- The diff includes new modules or significant architectural changes (new files, renamed files, major refactors)
- The PR branch name contains "spec", "proposal", "openspec", or "pipeline" (heuristic for spec-related work)

If none of these conditions are met, skip the spec-writer agent.

**Summary of agent selection:**

| PR type | Bug Hunter | Test Reviewer | Quality Reviewer | Spec Writer |
|---------|-----------|--------------|-----------------|-------------|
| Code only | yes | yes | yes | no |
| Code + specs | yes | yes | yes | yes |
| Spec only | no | no | no | yes |

### Agent prompts

Each agent receives the PR number and instructions to review using `gh pr diff {number}` and reading full files.

### Bug Hunter (agent: bug-hunter)
Prompt: "Review PR #{number} in this repository. Read CLAUDE.md first, then get the diff with `gh pr diff {number}`. For each changed file, read the full file to understand context. Hunt for bugs: memory issues, race conditions, logic errors, off-by-one, edge cases. Report findings with file:line, severity, and concrete trigger scenarios. If you find no bugs, say so."

### Test Reviewer (agent: test-reviewer)
Prompt: "Review PR #{number} in this repository. Read CLAUDE.md first, then get the diff with `gh pr diff {number}`. Analyze test coverage: which changed paths are untested? Are existing tests correct? Are assertions meaningful or could they silently pass on broken code? Check OpenSpec task files for self-validation quality if present. Report coverage gaps ranked by risk."

### Quality Reviewer (agent: quality-reviewer)
Prompt: "Review PR #{number} in this repository. Read CLAUDE.md first, then get the diff with `gh pr diff {number}`. Check convention adherence, allocation/ownership patterns, error handling consistency, documentation accuracy. If OpenSpec proposals exist for this change, verify implementation matches spec. Report findings with severity and specific recommendations."

### Spec Writer (agent: spec-writer) — CONDITIONAL
Prompt: "Review PR #{number} in this repository. Read CLAUDE.md first, then get the diff with `gh pr diff {number}`. This PR touches OpenSpec artifacts or introduces significant architectural changes. Review the OpenSpec artifacts (proposals, specs, designs, tasks) for quality: Are requirements testable with concrete scenarios? Are task descriptions specific enough for an agent to implement? Is self-validation runnable without human involvement? Does the spec-implementation alignment hold? Check `openspec/specs/` for existing main specs and verify delta specs reference them correctly. Report findings with severity and specific recommendations."

**IMPORTANT**: Launch all selected agents simultaneously using parallel Agent tool calls. Do NOT run them sequentially.

## Phase 3: Triage and Fix

When all launched agents complete, consolidate their findings into a single prioritized list:

### Triage rules
- **Fix now**: any finding rated high/critical by ANY reviewer, or flagged by multiple reviewers
- **Note on PR**: medium findings that are real but don't block merge — add as a PR comment
- **Skip**: low severity findings, style opinions, theoretical issues that can't trigger

For each "fix now" item:
1. Read the relevant file
2. Make the fix
3. Move to the next item

After all fixes are applied (skip this block for spec-only PRs with no code changes):
- Run the project's build command (check CLAUDE.md for specifics)
- Run the project's test command
- Run any format/lint checks

If build or tests fail, fix the failures before proceeding.

## Phase 4: Push Updates

If any fixes were made:
- Commit all fixes with a message: "Address review findings: {brief summary of what was fixed}"
- Push to the PR branch

Post a summary comment on the PR with what was found and fixed:
```bash
gh pr comment {number} --body "$(cat <<'EOF'
## Automated Review Summary

### Findings addressed
- {list of fixes made}

### Noted for future
- {medium findings not blocking merge}

### No issues found
- {areas where reviewers found nothing}

Reviewed by: bug-hunter, test-reviewer, quality-reviewer{, spec-writer if launched}
EOF
)"
```

## Output

When done, report:
- PR URL
- Count of findings by severity
- What was fixed vs noted vs skipped
- Whether build/tests pass after fixes
