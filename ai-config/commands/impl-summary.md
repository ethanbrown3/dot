Wrap up current changes by generating an implementation summary and creating a draft PR.

## 1. Detect Repository Context

```bash
# Check repo owner
REPO_OWNER=$(gh repo view --json owner -q '.owner.login' 2>/dev/null || echo "unknown")
echo "REPO_OWNER: $REPO_OWNER"

# Check if GPG signing is required (phantom org)
if [ "$REPO_OWNER" = "phantom" ]; then
    echo "⚠️  GPG_SIGNING: required (you'll need to touch your YubiKey for commits)"
else
    echo "GPG_SIGNING: not required"
fi
```

## 2. Detect Project Management Context

```bash
# Check for OpenSpec
if [ -d ".openspec" ] || [ -f "openspec.yaml" ] || [ -f "openspec.json" ]; then
    echo "CONTEXT: openspec"
fi

# Check for Linear (branch naming or config)
BRANCH=$(git branch --show-current 2>/dev/null)
if [[ "$BRANCH" =~ [A-Z]+-[0-9]+ ]] || [ -d ".linear" ]; then
    echo "CONTEXT: linear"
    # Extract ticket ID from branch name
    TICKET_ID=$(echo "$BRANCH" | grep -oE '[A-Z]+-[0-9]+' | head -1)
    echo "TICKET_ID: $TICKET_ID"
fi

# Check environment override
if [ -n "$CLAUDE_WORK_CONTEXT" ]; then
    echo "CONTEXT_OVERRIDE: $CLAUDE_WORK_CONTEXT"
fi
```

## 3. Gather Change Information

```bash
# Get current branch and base branch
CURRENT_BRANCH=$(git branch --show-current)
BASE_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main")

# Show commits on this branch
echo "=== Commits ==="
git log --oneline "$BASE_BRANCH".."$CURRENT_BRANCH" 2>/dev/null || git log --oneline -10

# Show changed files
echo ""
echo "=== Changed Files ==="
git diff --stat "$BASE_BRANCH"..."$CURRENT_BRANCH" 2>/dev/null || git diff --stat HEAD~5

# Check for uncommitted changes
echo ""
echo "=== Uncommitted Changes ==="
git status --short
```

## 4. Generate Implementation Summary

Based on the commits and changes, generate a summary following this format:

```markdown
## Summary
[1-3 bullet points describing the change at a high level]

## Implementation Notes

**Ticket:** [Linear ticket ID with link (e.g., https://linear.app/team/issue/ABC-123), OR OpenSpec reference, OR "N/A"]

**Key Decisions:**
- [Decision]: [Why this approach over alternatives]

**Intentional Omissions:**
- [What's not included and why]

**Known Tradeoffs:**
- [Compromises made, technical debt accepted]

**Review Focus Areas:**
- [Where reviewer attention is needed]

## Test Plan
- [ ] [How to verify the changes work]
```

Keep it concise. Focus on "why" not "what" - the diff shows what changed.

## 5. Commit Any Remaining Changes

If there are uncommitted changes that should be included:

**For phantom/ repos (GPG signing required):**
```bash
# User will need to touch YubiKey when this runs
git add -A
git commit -m "your commit message"
# ⚠️ Touch YubiKey now to sign the commit
```

**For other repos:**
```bash
git add -A
git commit -m "your commit message"
```

## 6. Verify and Push

```bash
# Verify working directory is clean before pushing
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Uncommitted changes detected. Commit or stash before pushing."
    git status --short
    exit 1
fi

# Push branch (set upstream if needed)
git push -u origin "$(git branch --show-current)"

# Create draft PR
gh pr create --draft --title "PR title here" --body "$(cat <<'EOF'
## Summary
...

## Implementation Notes
...

## Test Plan
...
EOF
)"
```

## 7. Output

After creating the PR, output:
- PR URL
- Reminder about GPG signing if phantom/ repo
- Any next steps (e.g., "Mark as ready for review when tests pass")
