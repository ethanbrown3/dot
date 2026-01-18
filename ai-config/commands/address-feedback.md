Fetch and address review feedback for PR #$ARGUMENTS.

## Fetch Feedback

```bash
PR=$ARGUMENTS

echo "=== PR Comments ==="
gh pr view $PR --json comments --jq '.comments[] | "[\(.author.login)] \(.body)\n---"'

echo ""
echo "=== Review Comments ==="
gh api repos/:owner/:repo/pulls/$PR/reviews \
  --jq '.[] | select(.state != "APPROVED") | "[\(.user.login) - \(.state)]\n\(.body)\n---"'

echo ""
echo "=== Inline Comments ==="
gh api repos/:owner/:repo/pulls/$PR/comments \
  --jq '.[] | "[\(.user.login)] \(.path):\(.line // .original_line)\n\(.body)\n---"'
```

## Process Each Item

For each piece of feedback:
1. **Valid & Clear** → Implement the fix
2. **Valid but Unclear** → Note what clarification is needed
3. **Disagree** → Note reasoning (will discuss with reviewer)
4. **Already Addressed** → Note if fixed in another commit

## Implement Fixes

1. Make the necessary code changes
2. Run tests: `npm test` or `pytest` or whatever is configured
3. Run linter if available

## Commit

```bash
git add -A
git commit -m "address review feedback

Addressed:
- [list items fixed]

Needs discussion:
- [list items needing clarification]

Declined:
- [list items with reasoning]"
```

## Push

```bash
git push
```

## Output

Provide a summary suitable for posting as a PR comment:
- What was addressed
- What needs clarification
- What you'd like to discuss
